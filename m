Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271072AbRHOH02>; Wed, 15 Aug 2001 03:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271076AbRHOH0T>; Wed, 15 Aug 2001 03:26:19 -0400
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:54658 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S271072AbRHOH0I>;
	Wed, 15 Aug 2001 03:26:08 -0400
Message-ID: <3B7A241A.1BD2158E@pobox.com>
Date: Wed, 15 Aug 2001 00:26:18 -0700
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Brian <hiryuu@envisiongames.net>
CC: dmaynor@iceland.oit.gatech.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.4.8 Resource leaks + limits
In-Reply-To: <3ce801c12548$b7971750$020a0a0a@totalmef> <20010815014328.A15395@iceland.oit.gatech.edu> <3B7A0F01.DC4CAE4@pobox.com> <200108150659.f7F6xeh16394@demai05.mw.mediaone.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian wrote:

> Probably both -- he's thinking more about the userspace side of it, though.
>
> /proc entries are okay for tweaking kernel parameters, but it seems a
> little weak as a primary interface.  You might as well have ps say 'Go
> grep it yourself!'

Something along the lines of the nice little program
sysctlconfig-gtk, to set the values with a gui interface,
stores them in e.g. /etc/sysctl.conf, and activtates the
new parameters with a mouse click....

Real men could edit /etc/sysctl.conf themselves,
while newbies could use the GUI program -

cu

jjs

