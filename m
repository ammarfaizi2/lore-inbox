Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263675AbTDGVcd (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 17:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263676AbTDGVcc (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 17:32:32 -0400
Received: from ivimey.org ([194.106.52.201]:29309 "EHLO gatemaster.ivimey.org")
	by vger.kernel.org with ESMTP id S263675AbTDGVcb (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 17:32:31 -0400
Message-Id: <5.2.0.9.0.20030407224225.020aa660@mailhost.ivimey.org>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Mon, 07 Apr 2003 22:44:03 +0100
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
Subject: Re: Problems booting PDC20276 with new IDE setup code.
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E91EBA9.3090503@gmx.net>
References: <5.2.0.9.0.20030407213727.0207ddf8@mailhost.ivimey.org>
 <5.2.0.9.0.20030407141330.00b346c0@mailhost.ivimey.org>
 <Pine.LNX.4.44.0304070201420.8701-100000@sharra.ivimey.org>
 <Pine.LNX.4.44.0304070201420.8701-100000@sharra.ivimey.org>
 <5.2.0.9.0.20030407141330.00b346c0@mailhost.ivimey.org>
 <5.2.0.9.0.20030407213727.0207ddf8@mailhost.ivimey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 22:20 07/04/2003, Carl-Daniel Hailfinger wrote:
>Was this text clear enough? If so, I might submit this as new help text ;-)

Yes, the title and help are fine: I'd encourage you to change it (for old & 
new drivers?)

However, is the reason it has worked for 2.4.20 that the .20 driver ignores 
the "disabled IDE" marker and uses it anyway, while the .21 driver takes 
notice of it?

Thanke,

Ruth 

