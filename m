Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318428AbSGYLui>; Thu, 25 Jul 2002 07:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318429AbSGYLuh>; Thu, 25 Jul 2002 07:50:37 -0400
Received: from [62.70.58.70] ([62.70.58.70]:56215 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S318428AbSGYLuh> convert rfc822-to-8bit;
	Thu, 25 Jul 2002 07:50:37 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: RAID problems
Date: Thu, 25 Jul 2002 13:54:04 +0200
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200207251354.04229.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all

What is there to do when the following happens:

a 16 drive RAID fails, giving me an error message telling 4 drives have gone 
dead. In fact only one has.

How can I hack the superblock on the reminding disks to bring them "up", so 
the kernel can start using the spare?

roy
-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

