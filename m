Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272433AbTHNPsR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 11:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272435AbTHNPsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 11:48:17 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:6674 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S272433AbTHNPsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 11:48:16 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test3 - the state of ACPI STR?
Date: Thu, 14 Aug 2003 19:47:53 +0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308141947.53641.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I compiled kernel with CONFIG_ACPI_SLEEP=y but doing echo 3 > /proc/acpi/sleep 
just hangs; SysRq works but task list is too long for video console.

if it is supposed to work I probably arrange for serial output; the system is 
ASUS CUSL2 desktop, STR works under Windows.

TIA

-andrey
