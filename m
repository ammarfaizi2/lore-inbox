Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbVJDR1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbVJDR1l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 13:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbVJDR1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 13:27:41 -0400
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:4508 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP id S932248AbVJDR1k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 13:27:40 -0400
Date: Tue, 4 Oct 2005 19:27:39 +0200 (CEST)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4 in-kernel file opening
Message-ID: <Pine.LNX.4.60.0510041924520.8210@kepler.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

can anybody tell me why there is no sys_open() exported in kernel/ksyms.c 
in 2.4 kernels while the sys_close() is there? And what is then the 
preferred way of opening files from within a 2.4 kernel module?

Thank you,
Martin
