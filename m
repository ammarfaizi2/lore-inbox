Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbUKIA45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbUKIA45 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 19:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbUKIA4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 19:56:33 -0500
Received: from rydia.net ([209.123.232.170]:33920 "EHLO locke.rydia.net")
	by vger.kernel.org with ESMTP id S261318AbUKIAzc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 19:55:32 -0500
From: Alistair John Strachan <alistair@devzero.co.uk>
Reply-To: alistair@devzero.co.uk
To: linux-kernel@vger.kernel.org
Subject: Kernel or failing harddisc?
Date: Tue, 9 Nov 2004 00:54:48 +0000
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411090054.48164.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Periodically, especially while playing large files with Xine (~1.4GB OGMs), 
playback will pause for up to 10 seconds. I see the following in dmesg;

hda: dma_timer_expiry: dma status == 0x64
hda: DMA interrupt recovery
hda: lost interrupt

The drive then recovers and playback resumes, no problem.

Is this likely to be the first signs of a faulty HD, or is it some known 
problem? In the event that it's the HD, has anybody been able to successfully 
RMA a Maxtor which has this, albeit minor, problem?

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/AI Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
