Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262455AbUCCOPi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 09:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbUCCOPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 09:15:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:58541 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262455AbUCCOPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 09:15:38 -0500
Date: Wed, 3 Mar 2004 06:15:36 -0800
From: John Cherry <cherry@osdl.org>
Message-Id: <200403031415.i23EFarA029623@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.4-rc1 - 2004-03-02.22.30) - 1 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/video/console/mdacon.c:599: warning: initialization from incompatible pointer type
