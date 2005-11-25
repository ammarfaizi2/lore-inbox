Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161088AbVKYCEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161088AbVKYCEW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 21:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161090AbVKYCEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 21:04:22 -0500
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:24695 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1161088AbVKYCEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 21:04:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:Date:From:X-X-Sender:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
  b=OWgyLWkfzL+3Vht4wcqC5qG/ZIVV9IWHI58JWA3uafD8WSxoQYIRpxK2nUmuVm6fQ1IX88RKKb+zrj6bzZUrHET/NC0l8gZ5niSBG/gVDCDl6BSOmXlvpwjNqsGgo0XLrE0MRIvQ/PiHXf+tKzE3RLeSYBPb+2l4MBJv6fkk5wA=  ;
Date: Thu, 24 Nov 2005 21:04:04 -0500 (EST)
From: "J. Scott Kasten" <jscottkasten@yahoo.com>
X-X-Sender: jsk@ra.tetracon-eng.net
To: Nick Warne <nick@linicks.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] 1500 days uptime.
In-Reply-To: <200511242147.45248.nick@linicks.net>
Message-ID: <Pine.NEB.4.63.0511242101120.22616@ra.tetracon-eng.net>
References: <200511242147.45248.nick@linicks.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Impressive indeed.  I had a SPARC LX running Red Hat 6.1 or 6.2 I think it 
was, stripped down for a web server and I got 585 days out of it before I 
had to pull the plug to relocate it.  It weathered NIMBDA, an FTP exploit 
and numberous other things for nearly 2 years.

-Scott-

On Thu, 24 Nov 2005, Nick Warne wrote:

> Date: Thu, 24 Nov 2005 21:47:45 +0000
> From: Nick Warne <nick@linicks.net>
> To: linux-kernel@vger.kernel.org
> Subject: [OT] 1500 days uptime.
> 
> Hi all,
>
> BrrrrrrrrrrrrBrrrr
>
> That was me blowing my own trumpet again :-)
>
> Re:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0407.1/0651.html
>
> Now just hit 1500 days:
>
> -
> [nick@486Linux nick]$ last -xf /var/run/utmp runlevel
> runlevel (to lvl 3)                    Sun Oct 14 16:07 - 21:41 (1502+06:34)
>
> utmp begins Sun Oct 14 16:07:40 2001
> -
>
> Utterly remarkable - the box gets no maintenance at all.
>
> I would love to know how much data it has delivered, but alas, in 2001 I
> wasn't up-to-speed with that sort of thing :-)
>
> Nick
> -- 
> "Person who say it cannot be done should not interrupt person doing it."
> -Chinese Proverb
> My quake2 project:
> http://sourceforge.net/projects/quake2plus/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
