Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264989AbTFQVRN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 17:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264987AbTFQVRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 17:17:13 -0400
Received: from pizda.ninka.net ([216.101.162.242]:8410 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264957AbTFQVRK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 17:17:10 -0400
Date: Tue, 17 Jun 2003 14:25:37 -0700 (PDT)
Message-Id: <20030617.142537.128617883.davem@redhat.com>
To: bunk@fs.tum.de
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.5 patch] net/wireless: make two frequency_list static
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030617211044.GF29247@fs.tum.de>
References: <20030617211044.GF29247@fs.tum.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Adrian Bunk <bunk@fs.tum.de>
   Date: Tue, 17 Jun 2003 23:10:44 +0200

   the patch below makes both frequency_list static.
   
   I've tested the compilation with 2.5.72.

Applied, thanks.
