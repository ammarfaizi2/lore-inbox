Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264128AbTLOUHS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 15:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264129AbTLOUHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 15:07:17 -0500
Received: from smtp-out1.iol.cz ([194.228.2.86]:11908 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S264128AbTLOUHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 15:07:17 -0500
Date: Mon, 15 Dec 2003 21:06:41 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6 kgdb without serial port
Message-ID: <20031215200640.GA3724@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2.6 kgdb patches in -mm tree seem to contain kgdb-over-ethernet stuff,
but still require me to fill in serial port interrupt/address. Is
there easy way to make it work without serial port? [This notebook has
none :-(].
								Pavel
-- 
When do you have heart between your knees?
