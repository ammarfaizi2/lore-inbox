Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbVKKGcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbVKKGcB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 01:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbVKKGcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 01:32:01 -0500
Received: from smtp107.sbc.mail.re2.yahoo.com ([68.142.229.98]:41580 "HELO
	smtp107.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750896AbVKKGcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 01:32:00 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
Subject: Re: Kernel Panic 2.6.14-git (pictures)
Date: Fri, 11 Nov 2005 01:31:57 -0500
User-Agent: KMail/1.8.3
Cc: Robert Love <rml@novell.com>, Andrew Morton <akpm@osdl.org>,
       jesper.juhl@gmail.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20051110151214.M35138@linuxwireless.org> <1131680001.24968.4.camel@phantasy> <43743893.9080100@linuxwireless.org>
In-Reply-To: <43743893.9080100@linuxwireless.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511110131.57845.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 November 2005 01:22, Alejandro Bonilla Beeche wrote:
> Robert Love wrote:
> 
> >On Thu, 2005-11-10 at 17:55 -0800, Andrew Morton wrote:
> >
> >  
> >
> >>Yes, photos of the screen work very nicely, thanks.
> >>    
> >>
> >
> >Excellent!
> >
> >  
> >
> >>Hi, Robert ;)
> >>    
> >>
> >
> >Andrew.  ;-)
> >
> >Alejandro - there is Dmitry Torokhov that fixed this and I thought it
> >went in Linus's tree (it was in Greg's tree and he pushed it over a week
> >ago).
> >
> >Dmitry?
> >  
> >
> LOL, everyone is pointing to someone else... ;-)
>

Heh ;)

Alejandro, didn't you have another issue with pcspeaker driver in
conjunction with PNP? Did my patch moving inpu core into a separate
directory and registering it early help?

 
> Linus, can you please merge Dmitry's patch? ;o
> 

Thank you for testing it!

-- 
Dmitry
