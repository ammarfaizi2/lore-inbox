Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313898AbSEYHcV>; Sat, 25 May 2002 03:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313906AbSEYHcU>; Sat, 25 May 2002 03:32:20 -0400
Received: from adsl-64-171-6-148.dsl.sntc01.pacbell.net ([64.171.6.148]:11005
	"EHLO k2-400.lameter.com") by vger.kernel.org with ESMTP
	id <S313898AbSEYHcT>; Sat, 25 May 2002 03:32:19 -0400
Date: Sat, 25 May 2002 00:32:19 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.18 compilation failure ide_scsi 
Message-ID: <Pine.LNX.4.44.0205250031570.7716-100000@k2-400.lameter.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/ide/idedriver.o: In function `ata_module_init':
drivers/ide/idedriver.o(.text.init+0xa5f): undefined reference to
`idescsi_init'make: *** [vmlinux] Error 1



