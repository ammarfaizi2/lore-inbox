Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbUCSKR4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 05:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbUCSKR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 05:17:56 -0500
Received: from dwdmx2.dwd.de ([141.38.3.197]:44360 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id S262286AbUCSKRz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 05:17:55 -0500
Date: Fri, 19 Mar 2004 10:17:53 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@praktifix.dwd.de
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: IPMI does not work under 2.6.4-mm2 and 2.6.5-rc1-mm2
Message-Id: <Pine.LNX.4.58.0403191012120.18369@praktifix.dwd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

When booting one of these kernels and IPMI is compiled in (CONFIG_IPMI_HANDLER,
CONFIG_IPMI_DEVICE_INTERFACE and CONFIG_IPMI_SI) it will just hang solid
during boot. 2.6.3 and 2.6.4 both work.

My hardware is a Intel SE7501HG2 with the newes bios updates.

Holger

PS: Please cc me since I am not subscript.
