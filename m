Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264893AbUAIWOl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 17:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264894AbUAIWOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 17:14:41 -0500
Received: from [81.3.4.101] ([81.3.4.101]:57533 "HELO localhost")
	by vger.kernel.org with SMTP id S264893AbUAIWOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 17:14:39 -0500
From: "Christian Kivalo" <valo@valo.at>
To: <linux-kernel@vger.kernel.org>
Subject: RE: stability problems with 2.4.24/Software RAID/ext3
Date: Fri, 9 Jan 2004 23:14:38 +0100
Message-ID: <NMEHJKFGFEGJPIPOLFFEEEPODDAA.valo@valo.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-reply-to: <20040109185348.GA24499@piper.madduck.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, January 09, 2004 7:54 PM, martin f krafft wrote:
> Well, I can't find any other suitable ones, really. I can't seem to
> find HighPoints, there is 3ware and DawiControl, but I don't know
> which ones are supported by Linux.
>
> Maybe someone can give me a suggestion for a non-promise EIDE 133
> PCI controller that's natively supported by Linux.

Hi!

3ware cards are hardware raidcontrollers, they are supported.

I can get a dawicontrol card here in austria with a silicon image 680
chip on it. I use 3 cards with sil680 chip (because these are not as
expensive as the 3ware cards) with linux-2.4.23 and connected 6 disks as
master holding a raid5 array. Have'nt had any problems till yet (I have
this setup for ~2 month's now).


Christian

(sorry for broken mua, am currently forced to use this)

