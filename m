Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbVBDJsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbVBDJsa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 04:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263047AbVBDJs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 04:48:29 -0500
Received: from mail.enyo.de ([212.9.189.167]:33195 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S261964AbVBDJs0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 04:48:26 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: linux-kernel@vger.kernel.org
Subject: [OT] Decoding machine check exceptions on AMD Athlon XP 
Date: Fri, 04 Feb 2005 10:48:25 +0100
Message-ID: <877jlo64gm.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of my machines is running into an uncorrectable machine check
exception.  The MCA error code is 0x152, but AMD's documentation
("AMD64 Architecture Programmer's Manual Volume 2: System
Programming") only contains a self-reference and no actual explanation
of the error codes.

Any hints on how to obtain real documentation?
