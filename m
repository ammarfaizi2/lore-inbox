Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbTF0AgE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 20:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbTF0AgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 20:36:04 -0400
Received: from pizda.ninka.net ([216.101.162.242]:17073 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263179AbTF0AgD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 20:36:03 -0400
Date: Thu, 26 Jun 2003 17:44:08 -0700 (PDT)
Message-Id: <20030626.174408.88474571.davem@redhat.com>
To: bernie@develer.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [IPV4] Don't #include a dozen unneeded headers in
 net/ipv4/utils.c
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200306270247.14217.bernie@develer.com>
References: <200306270247.14217.bernie@develer.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It's already applied to both trees.
