Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWJVPzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWJVPzn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 11:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWJVPzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 11:55:42 -0400
Received: from mail.tweerlei.de ([85.183.132.91]:65285 "EHLO mail.tweerlei.de")
	by vger.kernel.org with ESMTP id S1751075AbWJVPzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 11:55:41 -0400
Message-ID: <453B9474.5010909@tweerlei.de>
Date: Sun, 22 Oct 2006 17:55:32 +0200
From: Robert Wruck <wruck@tweerlei.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Mark Lord <lkml@rtr.ca>,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.19-rc2] SATA boot problems
References: <4537697C.7080500@tweerlei.de> <4537DEFC.5050404@rtr.ca> <45388F24.6000407@gmail.com>
In-Reply-To: <45388F24.6000407@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you give a shot at the latest -mm (2.6.19-rc2-mm2)?  It contains
> device-detection-via-polling which is supposed to fix problems similar
> to yours.

I tried 2.6.19-rc2-mm2 and was not able to reproduce the bug so far.
Seems to be fixed :-)

Thanks,
Robert
