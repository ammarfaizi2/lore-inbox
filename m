Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263157AbUDPNNK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 09:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263161AbUDPNNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 09:13:10 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:22924 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263157AbUDPNNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 09:13:08 -0400
Date: Fri, 16 Apr 2004 15:13:07 +0200
From: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: help not functional in make menuconfig kernel 2.6.3
Message-ID: <20040416131307.GB6879@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

linux kernel 2.6.3
Device Drivers -> Character devices
the following entries have non-functional Help. Symptoms: after
placing the cursor on < Help > and pressing enter the screen is cleared
and redrawn again. No help is displayed at all.

Parallel printer support
Support for user-space parallel port device drivers
Texas instruments parallel link cable support
QIC-02 tape support

Cl<
