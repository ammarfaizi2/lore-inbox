Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265778AbUFINdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265778AbUFINdD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 09:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265780AbUFINbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 09:31:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:55689 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265749AbUFIN35 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 09:29:57 -0400
Date: Wed, 9 Jun 2004 06:29:56 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200406091329.i59DTuJh005153@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.7-rc3 - 2004-06-08.22.30) - 5 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*** Warning: "arpt_do_table" [net/ipv4/netfilter/arptable_filter.ko] undefined!
*** Warning: "arpt_register_table" [net/ipv4/netfilter/arptable_filter.ko] undefined!
*** Warning: "arpt_register_target" [net/ipv4/netfilter/arpt_mangle.ko] undefined!
*** Warning: "arpt_unregister_table" [net/ipv4/netfilter/arptable_filter.ko] undefined!
*** Warning: "arpt_unregister_target" [net/ipv4/netfilter/arpt_mangle.ko] undefined!
