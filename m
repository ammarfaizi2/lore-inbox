Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbWIQUHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWIQUHh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 16:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbWIQUHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 16:07:37 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:49197 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932390AbWIQUHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 16:07:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f34VCbS7GzeTBLFggi3ydwU1OBjC5Iu1IpqwAPpDNfE2cZ7XHgCn/tpviYzX1lpoa0lCNDoY0zLz9rDid4bJezYFSw16OT+93IcvrfgoaYtlnOGIqjIQogpGiiqD5/1ST020R50tH6m7fR0p69iWRehtxAhksarDs4jO6HB9Xys=
Message-ID: <6bffcb0e0609171307o6a4257e8p560fb809b3535980@mail.gmail.com>
Date: Sun, 17 Sep 2006 22:07:36 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: 8 hours of battery life on thinkpad x60
Cc: "kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060917194118.GA3477@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060917194118.GA3477@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 17/09/06, Pavel Machek <pavel@ucw.cz> wrote:
> hi!
>
> I did a presentation about getting 8 hours of runtime out of common
> notebooks. You can get it at
> http://atrey.karlin.mff.cuni.cz/~pavel/swsusp/8hours.odp . Biggest
> offenders are USB (being worked on) and SATA (controller eats 1W --
> more than spinning disk, strange!).

Thanks for a great presentation!

Bug -> http://www.stardust.webpages.pl/files/crap/bug.jpg

>                                                                 Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
