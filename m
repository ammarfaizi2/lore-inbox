Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266703AbUBRMxl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 07:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266704AbUBRMxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 07:53:41 -0500
Received: from s4.uklinux.net ([80.84.72.14]:57812 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id S266703AbUBRMxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 07:53:40 -0500
Date: Wed, 18 Feb 2004 07:59:13 +0000
To: linux-kernel@vger.kernel.org
Subject: pnp missing proc entries?
Message-ID: <20040218075913.GA12989@titan.home.hindley.uklinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Mark Hindley <mark@hindley.uklinux.net>
X-MailScanner-Titan: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I can see the calls to make the
>missing nodes in pnp_add_device() 

Sorry, that shold be pnp_interface_attach_device() called from
pnp_add_device()

M
