Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313694AbSDJUGN>; Wed, 10 Apr 2002 16:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313697AbSDJUGM>; Wed, 10 Apr 2002 16:06:12 -0400
Received: from dsl-65-186-161-49.telocity.com ([65.186.161.49]:22281 "EHLO
	nic.osagesoftware.com") by vger.kernel.org with ESMTP
	id <S313694AbSDJUGM>; Wed, 10 Apr 2002 16:06:12 -0400
Message-Id: <4.3.2.7.2.20020410160354.00d77a00@mail.osagesoftware.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Wed, 10 Apr 2002 16:06:08 -0400
To: "Calin A. Culianu" <calin@ajvar.org>
From: David Relson <relson@osagesoftware.com>
Subject: Re: Cannot compile mandrake 8.2 Kernel
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L2.0204101505220.5649-100000@rtlab.med.cornel
 l.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:10 PM 4/10/02, Calin A. Culianu wrote:

>The stupid mandrake 8.2 kernel (2.4.18-mdk6) won't compile.  I know,
>mandrake is kind of a newbie distro, but I needed to mess with that kernel
>for some reason (don't ask).
>
>Anyway it gets errors like the following then you do make modules.  I
>notices someone else also had the exact same problem.. also below is
>preprocessor output from that compile... I think the problem is due to
>some of the exported kernel symbols containing parens...:


Calin,

I think the proper place for this query is the Mandrake Expert mailing 
list, which can be subscribed to at expert@linux-mandrake.com.

Mandrake has been around for several years and I've used their distribution 
(and often their kernels) since Mandrake 7.0.  I think it's incorrect to 
blame their "newness".

What gcc are you running?  gcc-3.0.4 has worked fine for me in building 
2.4.18 kernels on 8.2.

David


