Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315267AbSGUXgI>; Sun, 21 Jul 2002 19:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315276AbSGUXgI>; Sun, 21 Jul 2002 19:36:08 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17932 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315267AbSGUXgI>; Sun, 21 Jul 2002 19:36:08 -0400
Date: Mon, 22 Jul 2002 00:39:13 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] serial-2.5.26-5.diff.bz2
Message-ID: <20020722003913.R26376@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The fruits of Ingo's wisdom and testing, now available from:

  http://www.arm.linux.org.uk/cvs/serial-2.5.26-5.diff.bz2

- serial console initialisation fix
- various smp fixes
- couple of build fixes

Please note that this almost matches the serial cvs, but contains one
extra bug fix.  This particular bug fix needs a little more work to
make it squeaky clean, so it hasn't been checked into cvs.  Serial cvs
at details can be found at:

  http://cvs.arm.linux.org.uk/cvs/

Enjoy.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

