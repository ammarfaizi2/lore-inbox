Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbUCQU1D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 15:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbUCQU1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 15:27:02 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:35464 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262026AbUCQU06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 15:26:58 -0500
Date: Wed, 17 Mar 2004 21:26:57 +0100
From: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: make menuconfig help bugreport #2
Message-ID: <20040317202657.GD8297@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SCSI generic support
"If you want to use SCSI CD-writers" - it is not clear whether an ATAPI
CD-writer run under SCSI emulation is being considered a SCSI CD-writer
or not.

Maybe a pointer to some page defining these terms would solve the
problem. It could define what the term "SCSI CD-writer" means - if it
means some virtual interface provideed by Linux kernel that is prepared
for the usage by the user, of it is a rectangular metallic box with a
pop-out beverage holder.

Cl<
