Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264317AbTDKHwz (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 03:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264316AbTDKHwz (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 03:52:55 -0400
Received: from denise.shiny.it ([194.20.232.1]:39340 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S264314AbTDKHww (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 03:52:52 -0400
Message-ID: <XFMail.20030411100430.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <200304101339.49895.pbadari@us.ibm.com>
Date: Fri, 11 Apr 2003 10:04:30 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Badari Pulavarty <pbadari@us.ibm.com>
Subject: RE: [patch for playing] Patch to support 4000 disks and maintain
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10-Apr-2003 Badari Pulavarty wrote:
> Hi,
>
> Here is the (sd) patch to support > 4000 disks on 32-bit dev_t work
> in 2.5.67-mm tree.
>
> This patch addresses the backward compatibility with device nodes
> issue. All the new disks will be addressed by only last major.
>
> SCSI has 16 majors. Each major supports 16 disks currently. [...]

4000 discs should be enough for anyone :)
Are >16 partitions/disc possible ?


Bye.

