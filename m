Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268443AbTANAYr>; Mon, 13 Jan 2003 19:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268444AbTANAYr>; Mon, 13 Jan 2003 19:24:47 -0500
Received: from pD9E6B814.dip.t-dialin.net ([217.230.184.20]:39809 "EHLO
	fefe.de") by vger.kernel.org with ESMTP id <S268443AbTANAYq>;
	Mon, 13 Jan 2003 19:24:46 -0500
Date: Tue, 14 Jan 2003 01:33:24 +0100
From: Felix von Leitner <leitner-linuxkernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: kernel nfsd module depmod error
Message-ID: <20030114003324.GA18358@fefe.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling the kernel nfsd as module fails at "make modules_install" with
depmod reporting a gazillion unresolved symbols.  This has been broken
for several versions now, it should really be fixed.  I have not tried
to compile the kernel nfsd into the kernel.

Felix
