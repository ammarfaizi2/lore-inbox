Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261787AbSJIPFM>; Wed, 9 Oct 2002 11:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261788AbSJIPFM>; Wed, 9 Oct 2002 11:05:12 -0400
Received: from 213-187-164-2.dd.nextgentel.com ([213.187.164.2]:31367 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S261787AbSJIPFL> convert rfc822-to-8bit;
	Wed, 9 Oct 2002 11:05:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: softdog doesn't work on 2.4.20-pre10?
Date: Wed, 9 Oct 2002 17:12:10 +0200
User-Agent: KMail/1.4.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200210091607.32769.roy@karlsbakk.net> <1034174409.1970.37.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1034174409.1970.37.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210091712.10987.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > hi
> >
> > I have the softdog running on some of my machines, and I noticed it
> > didn't work very well. I've got this little program feeding the dog
> > (attached), so if it gets killed, the machine should reboot.
>
> Make sure you have no way out set

ok. works with no way out, but still...

When I killed 'feedthedog', I sent it a SIGKILL, so it couldn't have shut down 
the softdog properly.

roy

-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

