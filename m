Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265237AbTFMHzh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 03:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265239AbTFMHzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 03:55:37 -0400
Received: from denise.shiny.it ([194.20.232.1]:18884 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S265237AbTFMHzg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 03:55:36 -0400
Message-ID: <XFMail.20030613100922.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Fri, 13 Jun 2003 10:09:22 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: linux-kernel@vger.kernel.org
Subject: Power saving mode
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I have a card which can enter a low power state. It turns
off some components but it leaves the PCI bus interface
active. To bring the card back to life it has to be
reinitialized from scratch. What "D" state is it ?  PCI
power management papers say that already in D1 state
i/o space is disabled. I'm a bit confused... I can't
find any doc about D0.5  :)


Bye.

