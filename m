Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265826AbUATWC0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 17:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265832AbUATWC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 17:02:26 -0500
Received: from smtp11.eresmas.com ([62.81.235.111]:57530 "EHLO
	smtp11.eresmas.com") by vger.kernel.org with ESMTP id S265826AbUATWCV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 17:02:21 -0500
Message-ID: <400DA560.6070706@wanadoo.es>
Date: Tue, 20 Jan 2004 23:02:08 +0100
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: lukasz@trabinski.net, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.25-pre6
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukasz Trabinski wrote:

> SMP (2x2.66GHz Intel), with scsi aic79xx  with kernel -pre6 crashed after
> 3 days.

as usual:

- run memtest86+ [1] and cpuburn [2] to check the HW.
- update the firmware(MOBO BIOS and BackPlane/ESM, SCSI, hard disks, ...)
  to latest levels.


[1] http://www.memtest.org
[2] http://users.ev1.net/~redelm

--
Software is like sex, it's better when it's bug free.

