Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263478AbTK1VNV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 16:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263479AbTK1VNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 16:13:21 -0500
Received: from mail.gmx.de ([213.165.64.20]:27868 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263478AbTK1VNU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 16:13:20 -0500
X-Authenticated: #11949556
From: Michael Schierl <schierlm-usenet@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: APM Suspend Problem
Date: Fri, 28 Nov 2003 22:12:57 +0100
Reply-To: schierlm@gmx.de
References: <WnPi.57n.5@gated-at.bofh.it> <WsPg.Xi.35@gated-at.bofh.it> <WAWd.BP.7@gated-at.bofh.it>
In-Reply-To: <WAWd.BP.7@gated-at.bofh.it>
X-Mailer: Forte Agent 1.93/32.576 English (American)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Message-Id: <S263478AbTK1VNU/20031128211320Z+12850@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Nov 2003 21:30:18 +0100, in linux.kernel you wrote:

>No luck; my ThinkPad still does not go into the proper power-saving mode. The LCD
>blanks out and the HD spins down, but it is not a real sleep mode.

Nearly the same on my Acer 210TEV. The LCD does not go blank, but the
HD spins down.

Worked on -test3, but not on later kernels (with or without that
patch). 

Michael
-- 
"New" PGP Key! User ID: Michael Schierl <schierlm@gmx.de>
Key ID: 0x58B48CDD    Size: 2048    Created: 26.03.2002
Fingerprint:  68CE B807 E315 D14B  7461 5539 C90F 7CC8
http://home.arcor.de/mschierlm/mschierlm.asc
