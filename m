Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUCQUYX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 15:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbUCQUYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 15:24:23 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:56711 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262050AbUCQUYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 15:24:21 -0500
Date: Wed, 17 Mar 2004 21:24:19 +0100
From: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: make menuconfig help bugreport
Message-ID: <20040317202419.GC8297@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SCSI CDROM support
"If you want to use a SCSI CD-ROM" - it is not clear (and is nowhere
else defined in the help) if running an ATAPI CDROM under SCSI emulation
is considered "using a SCSI CD-ROM" or not.

Cl<
