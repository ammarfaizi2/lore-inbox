Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbTDFJN1 (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 05:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbTDFJN1 (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 05:13:27 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2688 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262881AbTDFJN1 (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 05:13:27 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304060927.h369R2fw000268@81-2-122-30.bradfords.org.uk>
Subject: Re: Debugging hard lockups (hardware?)
To: nicku@vtc.edu.hk (Nick Urbanik)
Date: Sun, 6 Apr 2003 10:27:02 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E8FC9FB.A030ACFB@vtc.edu.hk> from "Nick Urbanik" at Apr 06, 2003 02:32:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This machine locks up solid every few days.  Caps Lock, Num Lock, Scroll Lock do
> not respond.  The NMI watchdog does not kick in.  Alt-SysRq-keys do not
> respond.  Logs show no hint of any problem (that I recognise) before lockup.
> Occurs often during scrolling e.g., Mozilla.  I swapped the Radeon 7000 for a
> 7500, then an Nvidia.
> 
> I guess hardware.  But memtest run exhaustively shows no problem.

Have you tried the CPUBURN utilities?

http://users.ev1.net/~redelm/

John.
