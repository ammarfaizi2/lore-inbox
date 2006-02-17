Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161164AbWBQHyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161164AbWBQHyO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 02:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161166AbWBQHyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 02:54:13 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:37362 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161164AbWBQHyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 02:54:13 -0500
Date: Fri, 17 Feb 2006 08:53:58 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Michael Kerrisk <mtk-manpages@gmx.net>, Roland McGrath <roland@redhat.com>
Subject: PTRACE_SETOPTIONS documentantion?
Message-ID: <20060217075358.GB9230@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r781 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm just wondering if there is any sort of documentation for the ptrace
request PTRACE_SETOPTIONS and its PTRACE_O_* flags available?
Or is this just some sort of "if you want to use this interface, read
the kernel sources" ? :)
The same question could be asked for PTRACE_GETEVENTMSG, PTRACE_GETSIGINFO
and PTRACE_SETSIGINFO.

Heiko
