Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbUFNE1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbUFNE1B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 00:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbUFNE1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 00:27:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:25995 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261862AbUFNE07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 00:26:59 -0400
Date: Sun, 13 Jun 2004 21:26:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [6/12] fix advansys.c highmem bugs
Message-Id: <20040613212611.1f548003.akpm@osdl.org>
In-Reply-To: <20040614003929.GU1444@holomorphy.com>
References: <20040614003148.GO1444@holomorphy.com>
	<20040614003331.GP1444@holomorphy.com>
	<20040614003459.GQ1444@holomorphy.com>
	<20040614003605.GR1444@holomorphy.com>
	<20040614003708.GS1444@holomorphy.com>
	<20040614003835.GT1444@holomorphy.com>
	<20040614003929.GU1444@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
>   * Added basic highmem support in drivers/scsi/advansys.c

14 out of 16 hunks FAILED -- saving rejects to file drivers/scsi/advansys.c.rej

Looks like this has been addressed in the bk scsi tree, only differently.
