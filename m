Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262148AbUK3QNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbUK3QNP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 11:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbUK3QNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 11:13:14 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:14222 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262148AbUK3QKX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 11:10:23 -0500
Date: Tue, 30 Nov 2004 17:10:16 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: Walking all the physical memory in an x86 system
In-Reply-To: <C863B68032DED14E8EBA9F71EB8FE4C2057CA977@azsmsx406>
Message-ID: <Pine.LNX.4.53.0411301709560.25639@yvahk01.tjqt.qr>
References: <C863B68032DED14E8EBA9F71EB8FE4C2057CA977@azsmsx406>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>dd_rescue /dev/mem copyofmem
>
>I'm not sure what dd_rescue is as I've never heard of
>it. However, I don't think such an operation can be done from userspace
>because I need the physical addresses of memory not the virtual ones.

/dev/mem *is* physical.



Jan Engelhardt
-- 
ENOSPC
