Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbWEJI57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbWEJI57 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 04:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWEJI57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 04:57:59 -0400
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:26245 "EHLO
	ppsw-7.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S964864AbWEJI56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 04:57:58 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Wed, 10 May 2006 09:57:31 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Joshua Hudson <joshudson@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Not mounting NTFS rw, 2.6.16.1, but does so on 2.6.15
In-Reply-To: <bda6d13a0605092320y5cca6e1co2228f52c9777c3b1@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0605100957040.28166@hermes-1.csi.cam.ac.uk>
References: <bda6d13a0605092320y5cca6e1co2228f52c9777c3b1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2006, Joshua Hudson wrote:
> which means cannot re-run lilo on my laptop, so Not progressing beyond
> 2.6.15 until fixed.
> Downloading 2.6.16.15 to try that version now.
> 
> 16kstacks patch was applied (I use ndiswrapper with broadcom drivers loaded).

What are the error messages?  (Run dmesg to find out.)

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/
