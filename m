Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318248AbSHPHfL>; Fri, 16 Aug 2002 03:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318252AbSHPHfL>; Fri, 16 Aug 2002 03:35:11 -0400
Received: from smtp.hexanet.fr ([81.23.32.141]:1802 "EHLO smtp.hexanet.fr")
	by vger.kernel.org with ESMTP id <S318248AbSHPHfL>;
	Fri, 16 Aug 2002 03:35:11 -0400
Date: Fri, 16 Aug 2002 09:38:47 +0200
From: Jean Delvare <khali@linux-fr.org>
To: starfire@dplanet.ch
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Bug in 2.4.19
Message-Id: <20020816093847.4ae5544e.khali@linux-fr.org>
Organization: linux-fr
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i386-portbld-freebsd4.5)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello

> After compiling 2.4.19 (Debian kernel-source-2.4.19-1), I've had
> several kernel bugs. I've added the messages of two that I got in the
> log. The others are similar. I re-changed to 2.4.18 (Debian
> kernel-source-2.4.18-5) and everything works fine.

Are you able to reproduce the problem without loading the NVidia
drivers? If no, you know who to complain to.

Second question, are the Zip100-drive-related errors in dmesg something
unusual and thus probably related to the problem?

> I/O error: dev 08:00, sector 0
> unable to read partition table

If yes, I'd suggest you disable ppa for a while and see if it solves the
problem.

-- 
Jean Delvare

