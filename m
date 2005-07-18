Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbVGRNlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbVGRNlJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 09:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVGRNlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 09:41:08 -0400
Received: from soufre.accelance.net ([213.162.48.15]:48329 "EHLO
	soufre.accelance.net") by vger.kernel.org with ESMTP
	id S261745AbVGRNlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 09:41:05 -0400
Message-ID: <42DBB18E.7090707@xenomai.org>
Date: Mon, 18 Jul 2005 15:41:34 +0200
From: Philippe Gerum <rpm@xenomai.org>
Organization: Xenomai
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [patch] I-pipe 2.6.12-v0.9-02
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt pipeline patch v0.9-02 has been released, fixing a latency 
spot and a bug in the deferred printk() mechanism.

A split version of the patch for x86, ppc32 and ia64 is available here: 
http://download.gna.org/adeos/patches/v2.6/ipipe/split/

Patch sequence to build a Linux 2.6.12 tree with I-pipe support:

http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.12.tar.bz2
http://download.gna.org/adeos/patches/v2.6/ipipe/ipipe-2.6.12-v0.9-02.patch

-- 

Philippe.
