Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVACSwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVACSwV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 13:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbVACSwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 13:52:20 -0500
Received: from mail1.webmaster.com ([216.152.64.168]:781 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S261782AbVACSvx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 13:51:53 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>
Cc: <tonyosborne_a@hotmail.com>
Subject: RE: Main CPU- I/O CPU interaction
Date: Mon, 3 Jan 2005 10:51:43 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKAEDBANAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <BAY14-F83B94FD7D13C5D19883F795900@phx.gbl>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Mon, 03 Jan 2005 10:27:45 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Mon, 03 Jan 2005 10:27:46 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> from doing the low level I/O operations. However, if i am editing and 
> updating a big size file and i want to save
> it afterwards, i  notice my PC getting blocked while saving the 
> file which 
> theoritically should NOT happen as it is up to the I/O device 
> processor and 

	What does "PC getting blocked" mean?

	DS


