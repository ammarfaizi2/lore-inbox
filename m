Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264023AbTJ1QS6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 11:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264027AbTJ1QS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 11:18:58 -0500
Received: from smtp-out1.blueyonder.co.uk ([195.188.213.4]:26382 "EHLO
	smtp-out1.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S264023AbTJ1QS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 11:18:57 -0500
Date: Tue, 28 Oct 2003 16:17:44 +0000
From: Ciaran McCreesh <ciaranm@firedrop.org.uk>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CPU-Test similar to Memtest?
Message-Id: <20031028161744.12a33fa9.ciaranm@firedrop.org.uk>
In-Reply-To: <20031028160550.GA855@rdlg.net>
References: <20031028160550.GA855@rdlg.net>
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Oct 2003 16:18:56.0329 (UTC) FILETIME=[2FACCB90:01C39D6F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Oct 2003 11:05:50 -0500 "Robert L. Harris"
<Robert.L.Harris@rdlg.net> wrote:
| I'm going to run MEMTEST today when I get home and get a chance to
| make a bootable CD but I'm wondering if there might be a "CPUTEST" or
| such utility anyone knows of that'll poke and prod a dual athalon real
| well and make sure I don't have a flaky cpu.

I've found 'cpuburn' to work well for x86 CPUs:

http://users.ev1.net/~redelm/

-- 
Ciaran McCreesh
Mail:       ciaranm at firedrop.org.uk
Web:        www.firedrop.org.uk
System:     Gentoo Base System version 1.4.3.10p1 Linux 2.4.20-gentoo-r7
