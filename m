Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264495AbTFQBKR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 21:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264496AbTFQBKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 21:10:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19410 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264495AbTFQBKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 21:10:15 -0400
Date: Mon, 16 Jun 2003 18:19:46 -0700 (PDT)
Message-Id: <20030616.181946.22044667.davem@redhat.com>
To: girouard@us.ibm.com
Cc: stekloff@us.ibm.com, janiceg@us.ibm.com, jgarzik@pobox.com,
       lkessler@us.ibm.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       niv@us.ibm.com
Subject: Re: patch for common networking error messages
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <OFDD16F58E.35149C65-ON85256D47.0081D564@us.ibm.com>
References: <OFDD16F58E.35149C65-ON85256D47.0081D564@us.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Janice Girouard <girouard@us.ibm.com>
   Date: Mon, 16 Jun 2003 19:44:22 -0500
   
   It sounds like you are proposing a new family for the netlink
   subsystem.

Exactly, you have to create this.
