Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313743AbSDJUWz>; Wed, 10 Apr 2002 16:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313757AbSDJUWy>; Wed, 10 Apr 2002 16:22:54 -0400
Received: from rtlab.med.cornell.edu ([140.251.145.175]:33711 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S313743AbSDJUWy>;
	Wed, 10 Apr 2002 16:22:54 -0400
Date: Wed, 10 Apr 2002 16:22:54 -0400 (EDT)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: <calin@rtlab.med.cornell.edu>
To: David Relson <relson@osagesoftware.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Cannot compile mandrake 8.2 Kernel
In-Reply-To: <4.3.2.7.2.20020410160354.00d77a00@mail.osagesoftware.com>
Message-ID: <Pine.LNX.4.33L2.0204101622080.5815-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ah.  I am using gcc 2.96-76.  I think that may be the cause of my
problems?  You are right, of course, this isn't the right place to ask
this question.  I crossposted this on their mailing list as well, but
since i noticed one guy in here on April 4 also had this exact same
problem, I thought he or someone else might have encountered this and
solved it...


On Wed, 10 Apr 2002, David Relson wrote:

> At 03:10 PM 4/10/02, Calin A. Culianu wrote:
>
> >The stupid mandrake 8.2 kernel (2.4.18-mdk6) won't compile.  I know,
> >mandrake is kind of a newbie distro, but I needed to mess with that kernel
> >for some reason (don't ask).
> >
> >Anyway it gets errors like the following then you do make modules.  I
> >notices someone else also had the exact same problem.. also below is
> >preprocessor output from that compile... I think the problem is due to
> >some of the exported kernel symbols containing parens...:
>
>
> Calin,
>
> I think the proper place for this query is the Mandrake Expert mailing
> list, which can be subscribed to at expert@linux-mandrake.com.
>
> Mandrake has been around for several years and I've used their distribution
> (and often their kernels) since Mandrake 7.0.  I think it's incorrect to
> blame their "newness".
>
> What gcc are you running?  gcc-3.0.4 has worked fine for me in building
> 2.4.18 kernels on 8.2.
>
> David
>
>

