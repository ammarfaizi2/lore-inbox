Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261493AbTCOTcI>; Sat, 15 Mar 2003 14:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261498AbTCOTcI>; Sat, 15 Mar 2003 14:32:08 -0500
Received: from mako.theneteffect.com ([63.97.58.10]:47109 "EHLO
	mako.theneteffect.com") by vger.kernel.org with ESMTP
	id <S261493AbTCOTcH>; Sat, 15 Mar 2003 14:32:07 -0500
From: Mitch Adair <mitch@theneteffect.com>
Message-Id: <200303151942.h2FJgwP19650@mako.theneteffect.com>
Subject: 2.5.64: menuconfig: help within choice blocks doesn't show?
To: linux-kernel@vger.kernel.org
Date: Sat, 15 Mar 2003 13:42:58 -0600 (CST)
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed the help text for menuconfig options doesn't show if it's inside
a Kconfig choice block.  For example under "Processor type and features" ->
"Processor family" none of the help shows for the processor types even
though the help texts are present in the Kconfig file.

Is anybody else seeing this?

	M
