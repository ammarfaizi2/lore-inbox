Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262902AbVHEIYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbVHEIYN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 04:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262907AbVHEIYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 04:24:13 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:35601 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262902AbVHEIYM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 04:24:12 -0400
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Speedup FAT filesystem directory reads
References: <200508040333.44935.annabellesgarden@yahoo.de>
	<87wtn1ail7.fsf@devron.myhome.or.jp>
	<200508050254.08418.annabellesgarden@yahoo.de>
	<87zmrx5fp8.fsf@devron.myhome.or.jp>
	<Pine.LNX.4.61.0508050810250.19610@yvahk01.tjqt.qr>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 05 Aug 2005 17:23:54 +0900
In-Reply-To: <Pine.LNX.4.61.0508050810250.19610@yvahk01.tjqt.qr> (Jan Engelhardt's message of "Fri, 5 Aug 2005 08:10:56 +0200 (MEST)")
Message-ID: <87r7d8zt9h.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

> |Exception:  If your mailer is mangling patches then someone may ask
> |you to re-send them using MIME.
>
> from the doc ;)

Oh, sure, I missed to read it :)  But my mailer is actually sane.
Please double check your mailer.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
