Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbTFQBPN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 21:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264498AbTFQBPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 21:15:12 -0400
Received: from pizda.ninka.net ([216.101.162.242]:23762 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264496AbTFQBPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 21:15:10 -0400
Date: Mon, 16 Jun 2003 18:24:43 -0700 (PDT)
Message-Id: <20030616.182443.91785412.davem@redhat.com>
To: ahaas@airmail.net
Cc: sparclinux@vger.kernel.org, ultralinux@vger.kernel.org,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] C99 initializers for asm-sparc/include/xor.h
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030617004800.GD21500@artsapartment.org>
References: <20030617004800.GD21500@artsapartment.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Art Haas <ahaas@airmail.net>
   Date: Mon, 16 Jun 2003 19:48:00 -0500

   These two patches fix the xor.h files to use C99 initializers. The
   patches are against the current BK, and both are untested as I don't
   have access to the hardware.

Applied, thanks Art.
