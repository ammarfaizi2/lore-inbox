Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262912AbTDFKoL (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 06:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbTDFKoL (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 06:44:11 -0400
Received: from coral.ocn.ne.jp ([211.6.83.180]:41933 "HELO
	smtp.coral.ocn.ne.jp") by vger.kernel.org with SMTP id S262912AbTDFKoK (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 06:44:10 -0400
Date: Sun, 6 Apr 2003 19:55:39 +0900
From: Bruce Harada <bharada@coral.ocn.ne.jp>
To: Nick Urbanik <nicku@vtc.edu.hk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Debugging hard lockups (hardware?)
Message-Id: <20030406195539.5bc73ed8.bharada@coral.ocn.ne.jp>
In-Reply-To: <3E8FC9FB.A030ACFB@vtc.edu.hk>
References: <3E8FC9FB.A030ACFB@vtc.edu.hk>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 06 Apr 2003 14:32:27 +0800
Nick Urbanik <nicku@vtc.edu.hk> wrote:

> Dear team,
> 
> This machine locks up solid every few days.  Caps Lock, Num Lock, Scroll
> Lock do not respond.  The NMI watchdog does not kick in.  Alt-SysRq-keys do
> not respond.  Logs show no hint of any problem (that I recognise) before
> lockup. Occurs often during scrolling e.g., Mozilla.  I swapped the Radeon
> 7000 for a 7500, then an Nvidia.

Does booting with 'noapic' make any difference?
