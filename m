Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262579AbVAUTdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262579AbVAUTdy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 14:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbVAUTdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 14:33:54 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:27320 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S262579AbVAUTdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 14:33:49 -0500
Subject: md and RAID 5 [was Re: LVM2]
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1106250687.3413.6.camel@localhost.localdomain>
References: <1106250687.3413.6.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 21 Jan 2005 12:33:48 -0700
Message-Id: <1106336028.3369.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you all for having been so kind in your responses and help.

However, there is one more set of questions I have.

Does the md (software raid) have disk size or raid volume limits?

If I am using such things as USB or 1394 disks, is there a way to use
labels in /etc/raidtab and with the tools so that when the disks, if
they do, get renumbered in /dev that all works fine. I am aware that the
kernel will autodetect these devices, but that the raidtab needs to be
consistent. This is what I am trying to figure out how to do.

Thank you,
Trever Adams
--
"A modest woman, dressed out in all her finery, is the most tremendous
object in the whole creation." -- Goldsmith 

