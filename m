Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272290AbTHIJFk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 05:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272291AbTHIJFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 05:05:40 -0400
Received: from fep04.swip.net ([130.244.199.132]:5860 "EHLO fep04-svc.swip.net")
	by vger.kernel.org with ESMTP id S272290AbTHIJFj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 05:05:39 -0400
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: APM working on SMP machines?
Date: Sat, 9 Aug 2003 11:05:27 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308091105.27619.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I would like to know when will work APM on SMP machines?
I use Dell  workstation 400 with 2 P2 CPUs.
When I remove one CPU APM works, when I have 2 in case APM
doesn't work

I can't use ACPI, because this machine doesn't support it.

apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
apm: disabled - APM is not SMP safe.

Thanks for fixing and reply - it's very uncomfortable
switch off computer manually :(

Michal

