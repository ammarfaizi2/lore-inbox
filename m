Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283786AbRLMJjJ>; Thu, 13 Dec 2001 04:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283766AbRLMJit>; Thu, 13 Dec 2001 04:38:49 -0500
Received: from mta04.mail.au.uu.net ([203.2.192.84]:8156 "EHLO
	mta04.mail.mel.aone.net.au") by vger.kernel.org with ESMTP
	id <S283783AbRLMJim>; Thu, 13 Dec 2001 04:38:42 -0500
Date: Thu, 13 Dec 2001 20:48:10 +1100
From: Caleb Moore <donscarletti@ozemail.com>
To: linux-kernel@vger.kernel.org
Subject: swapping problem on kernel >= 2.4.14
Message-ID: <20011213204810.A2759@Duron>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tried to change to kernel 2.4.16 from 2.4.13 and my system crashes 
every time it starts using swap. This is the case down to 2.4.14 even when 
it is built using default options. My system is a AMD duron with 128MB of 
RAM and two swap partitions both 128MB on my non boot hard drive.

could someone please fix this

thanks
