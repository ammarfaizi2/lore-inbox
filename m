Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbUCQUXF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 15:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbUCQUXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 15:23:05 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:19591 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262046AbUCQUXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 15:23:03 -0500
Date: Wed, 17 Mar 2004 21:23:02 +0100
From: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: SCSI emulation - CD-R
Message-ID: <20040317202302.GB8297@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

When I want an ATAPI CD-writer to appear on device (21,0) (/dev/sg0)
using the scsi emulation mechanisms, which bits have to be on and off
from the following 4 config bits in make menuconfig?
* IDE/ATAPI CDROM support
* SCSI emulation support
* SCSI CDROM support
* SCSI generic support

How can this information be derived from linux kernel documentation? I
would like to understand the mechanism beyond deriving this information
from the linux kernel documentation so that next time, when solving some
other problem, I could use the same approach and not need to write here
on linux-kernel.

Cl<
