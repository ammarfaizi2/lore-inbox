Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264432AbUESRDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264432AbUESRDt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 13:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbUESRDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 13:03:49 -0400
Received: from fire.osdl.org ([65.172.181.4]:43757 "EHLO fire-2.osdl.org")
	by vger.kernel.org with ESMTP id S264432AbUESRDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 13:03:49 -0400
Subject: IA32 (2.6.6 - 2004-5-18.22.30) - 1 New warning (gcc 3.2.2)
From: John Cherry <cherry@osdl.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1084986227.12134.5.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 19 May 2004 10:03:48 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/fealnx.c:1811: warning: passing arg 1 of `_raw_spin_unlock'
from incompatible pointer type

