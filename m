Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285471AbRLNTi5>; Fri, 14 Dec 2001 14:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285472AbRLNTis>; Fri, 14 Dec 2001 14:38:48 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:14043
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S285471AbRLNTik>; Fri, 14 Dec 2001 14:38:40 -0500
Date: Fri, 14 Dec 2001 14:27:07 -0500
Message-Id: <200112141927.fBEJR7L13821@snark.thyrsus.com>
From: "Eric S. Raymond" <esr@snark.thyrsus.com>
To: rmk@arm.linux.org.uk, linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: It's all you, ARM port guys!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are the *only* remaining missing Configure.help entries:

CPU_ARM1020_CPU_IDLE: arch/arm/mm/proc-arm1020.S
CPU_ARM1020_FORCE_WRITE_THROUGH: arch/arm/config.in arch/arm/mm/proc-arm1020.S
CPU_ARM1020_ROUND_ROBIN: arch/arm/config.in arch/arm/mm/proc-arm1020.S
CPU_ARM920_CPU_IDLE: arch/arm/config.in arch/arm/mm/proc-arm920.S
CPU_ARM926_CPU_IDLE: arch/arm/config.in arch/arm/mm/proc-arm926.S
CPU_ARM926_ROUND_ROBIN: arch/arm/config.in arch/arm/mm/proc-arm926.S
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

A ``decay in the social contract'' is detectable; there is a growing
feeling, particularly among middle-income taxpayers, that they are not
getting back, from society and government, their money's worth for
taxes paid. The tendency is for taxpayers to try to take more control
of their finances ..
	-- IRS Strategic Plan, (May 1984)
