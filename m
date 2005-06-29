Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262299AbVF2JDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbVF2JDJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 05:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262487AbVF2JDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 05:03:08 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:30082 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S262299AbVF2JDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 05:03:05 -0400
Message-ID: <42C263C3.7030905@ens-lyon.org>
Date: Wed, 29 Jun 2005 11:02:59 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.13-rc1
References: <Pine.LNX.4.58.0506282310040.14331@ppc970.osdl.org> <42C251BE.7030505@ens-lyon.org>
In-Reply-To: <42C251BE.7030505@ens-lyon.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 29.06.2005 09:46, Brice Goglin a écrit :
> Le 29.06.2005 08:30, Linus Torvalds a écrit :
> 
>>Ok, guys,
>> there was a lot of stuff pending after 2.6.12, and in the week and a half
>>since the release, the current diff against it has grown to almost three
>>megabytes compressed.
> 
> 
> Hi Linus,
> 
> My video and music is played too fast. The ratio seems to be 1,6666.
> Note that I'm using HZ=1000. But I'm also using HZ=1000 in -mm for a
> while without any problem.

Well, it didn't happen again after a reboot.
I'll try to see if I can reproduce it.

Brice
