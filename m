Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263780AbTDXQ5k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 12:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263781AbTDXQ5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 12:57:40 -0400
Received: from air-2.osdl.org ([65.172.181.6]:4823 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263780AbTDXQ5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 12:57:38 -0400
Subject: [ANNOUNCE] OSDL Whitepaper: "Reducing System Reboot Time With
	Kexec"
From: Andy Pfiffer <andyp@osdl.org>
To: fastboot@osdl.org
Cc: cgl_discussion@osdl.org, dcl_discussion@osdl.org,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1051204164.4840.17.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Apr 2003 10:09:24 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

URL: http://www.osdl.org/docs/reducing_system_reboot_time_with_kexec.pdf

Title:
Reducing System Reboot Time With kexec

Abstract:
kexec is a developing feature for Linux 2.5.x that allows an x86 Linux
kernel to load and run another kernel instead of the platform BIOS and
bootloader. By skipping the platform BIOS during a reboot, kexec can
reduce downtime in enterprise class systems, and reduce turn-around time
for Linux kernel developers. This paper presents measurements of boot
time reduction through the use of kexec.



