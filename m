Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262803AbVHEBfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262803AbVHEBfP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 21:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbVHEBfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 21:35:15 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:3084 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262803AbVHEBfN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 21:35:13 -0400
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Speedup FAT filesystem directory reads
References: <200508040333.44935.annabellesgarden@yahoo.de>
	<87wtn1ail7.fsf@devron.myhome.or.jp>
	<200508050254.08418.annabellesgarden@yahoo.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 05 Aug 2005 10:34:59 +0900
In-Reply-To: <200508050254.08418.annabellesgarden@yahoo.de> (Karsten Wiese's message of "Fri, 5 Aug 2005 02:54:08 +0200")
Message-ID: <87zmrx5fp8.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karsten Wiese <annabellesgarden@yahoo.de> writes:

> Looks better, is smaller and works equally well here, thanks.
> I had to hand apply it though as it was slightly scrambled
> (by my mail client?) so patch couldn't handle it.
> Please send patches as attachment.

We like a plain text, not attachment, see Documentation/SubmittingPatches.
Anyway, thanks for nice work.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
