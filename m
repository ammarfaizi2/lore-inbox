Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbVKTU36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbVKTU36 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 15:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbVKTU36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 15:29:58 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:52964 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750819AbVKTU36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 15:29:58 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Xose Vazquez Perez <xose.vazquez@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: feature-removal-schedule
Date: Mon, 21 Nov 2005 07:29:45 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <vfm1o1d6rjv4peect4n35isgfa95ll9q73@4ax.com>
References: <43806304.7090509@gmail.com>
In-Reply-To: <43806304.7090509@gmail.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Nov 2005 12:50:28 +0100, Xose Vazquez Perez <xose.vazquez@gmail.com> wrote:

>What:   i2c sysfs name change: in1_ref, vid deprecated in favour of cpu0_vid
>When:   November 2005
>Files:  drivers/i2c/chips/adm1025.c, drivers/i2c/chips/adm1026.c
>Why:    Match the other drivers' name for the same function, duplicate names
>         will be available until removal of old names.
>Who:    Grant Coady <gcoady@gmail.com>
>
>I think that this already was fixed.
>Would you mind to send a patch to feature-removal-schedule.txt.

Done already :o)

Patch is in 2.6.15-rc1-mm1, not 2.6.15-rc2.  Thanks for reminder.

Grant.
