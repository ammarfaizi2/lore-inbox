Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbTJMXO0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 19:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbTJMXO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 19:14:26 -0400
Received: from [212.97.163.22] ([212.97.163.22]:5004 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S262094AbTJMXOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 19:14:25 -0400
Date: Tue, 14 Oct 2003 01:14:13 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: ACPI in -pre7 builds with -Os
Message-ID: <20031013231413.GA4189@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

$subject:

drivers/acpi/Makefile:

ACPI_CFLAGS := -Os

Uh ?

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.23-pre7-jam1 (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-2mdk))
