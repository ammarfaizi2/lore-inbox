Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264638AbUGZAA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264638AbUGZAA7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 20:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264639AbUGZAA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 20:00:59 -0400
Received: from dsl-64-30-195-78.lcinet.net ([64.30.195.78]:8662 "EHLO
	jg555.com") by vger.kernel.org with ESMTP id S264638AbUGZAA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 20:00:58 -0400
Message-ID: <057601c472a3$9df39ac0$d100a8c0@W2RZ8L4S02>
From: "Jim Gifford" <maillist@jg555.com>
To: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
References: <200407261445.i6QEjAS04697@freya.yggdrasil.com>
Subject: Re: Future devfs plans
Date: Sun, 25 Jul 2004 17:00:52 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Adam J. Richter" <adam@yggdrasil.com>
To: <linux-kernel@vger.kernel.org>
Sent: Monday, July 26, 2004 7:45 AM
Subject: Future devfs plans


> Do not delete devfs.
>
> devfs allows drivers to be loaded when user level programs
> need them,
> -
So will a proper modprobe.conf file. You don't need devfs for autoloading of
modules.

