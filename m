Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269243AbUJWEjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269243AbUJWEjk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 00:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268268AbUJWEcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 00:32:47 -0400
Received: from [211.58.254.17] ([211.58.254.17]:32913 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S269243AbUJWEbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 00:31:15 -0400
Date: Sat, 23 Oct 2004 13:31:11 +0900
From: Tejun Heo <tj@home-tj.org>
To: rusty@rustcorp.com.au, mochel@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC/PATCH] Per-device parameter support (12/16)
Message-ID: <20041023043111.GM3456@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 dp_12_module_param_arr_apply.diff

 This is the 12nd patch of 16 patches for devparam.

 Applies module_param_array/arr() changes.  As this patch is quite
large and mundane, I'll post only the URL here.


Signed-off-by: Tejun Heo <tj@home-tj.org>


http://home-tj.org/devparam/20041023/dp_12_module_param_arr_apply.diff
