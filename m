Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbUBHW62 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 17:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbUBHW61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 17:58:27 -0500
Received: from mail2.scram.de ([195.226.127.112]:14867 "EHLO mail2.scram.de")
	by vger.kernel.org with ESMTP id S264275AbUBHW61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 17:58:27 -0500
Date: Sun, 8 Feb 2004 23:57:59 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@localhost
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: tms380tr patches (3 parts)
Message-ID: <Pine.LNX.4.58.0402082355210.1327@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

these 3 patches are against the current BK version of 2.6.3-rc1.
The following problems are being addressed:

- some bug fixes (1/3)
- remove the internal queue of the driver (2/3)
- use firmware class to download firmware to card (3/3)

Please apply.

Thanks,
--jochen
