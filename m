Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262326AbSLJPx1>; Tue, 10 Dec 2002 10:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262414AbSLJPx1>; Tue, 10 Dec 2002 10:53:27 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:6866 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S262326AbSLJPx0>; Tue, 10 Dec 2002 10:53:26 -0500
Date: Tue, 10 Dec 2002 17:01:11 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: James Morris <jmorris@intercode.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.2 networking, NET_BH latency
Message-ID: <20021210160111.GD23479@laguna.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	James Morris <jmorris@intercode.com.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021210155632.GC23479@laguna.alcove-fr> <Mutt.LNX.4.44.0212110257180.1749-100000@blackbird.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Mutt.LNX.4.44.0212110257180.1749-100000@blackbird.intercode.com.au>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 02:57:32AM +1100, James Morris wrote:

> On Tue, 10 Dec 2002, Stelian Pop wrote:
> 
> > > Can you reproduce the problem with a vanilla 2.2.23 kernel?
> > 
> > I didn't try yet, but it is on my list.
> > 
> > Should I interpret your message as some changes between 2.2.18 and 2.2.23
> > could be responsible for that behaviour or you are just shooting in the
> > dark ? :-)
> > 
> 
> No.

I take it as 'no, this was not a shot in the dark' then... 

Could you please explain a bit more the problem ? Maybe point me to
some networking changes in particular ? (in my particular case, it
may be simpler to just try a specific patch instead of going directly
to 2.2.23...).

Thanks,

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
