Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265656AbTFSAcT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 20:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265662AbTFSAcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 20:32:19 -0400
Received: from air-2.osdl.org ([65.172.181.6]:63418 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265656AbTFSAcO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 20:32:14 -0400
Subject: [KEXEC][ANNOUNCE] kexec for 2.5.72-mm1 available
From: Andy Pfiffer <andyp@osdl.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@zip.com.au>
In-Reply-To: <1055878770.1203.9.camel@andyp.pdx.osdl.net>
References: <1055878770.1203.9.camel@andyp.pdx.osdl.net>
Content-Type: text/plain
Organization: 
Message-Id: <1055983570.1230.5.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 18 Jun 2003 17:46:10 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A patch for kexec in 2.5.72-mm1 is now available.  This patch is based
upon the stable 2.5.72 version.

This patch has been lightly tested to work on a dual-proc P4-1.7GHz Xeon
system.  If you try it, and you use the VESA framebuffer, expect
darkness on your screen during the reboot. ;^)

More info here:
http://www.osdl.org/archive/andyp/bloom/Code/Linux/Kexec/index.html

The patch:
http://www.osdl.org/archive/andyp/kexec/2.5.72-mm1/kexec2-2.5.72-mm1-full.patch

Source for the matching user-mode tool:
http://www.osdl.org/archive/andyp/kexec/2.5.72-mm1/kexec-tools-1.8-2.5.72-mm1.tgz



