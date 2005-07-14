Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbVGNXPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbVGNXPR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 19:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbVGNXPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 19:15:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44992 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262692AbVGNXOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 19:14:31 -0400
Date: Thu, 14 Jul 2005 16:14:19 -0700
From: Chris Wright <chrisw@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add security_task_post_setgid
Message-ID: <20050714231419.GM9153@shell0.pdx.osdl.net>
References: <Pine.LNX.4.61.0507142339570.3256@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507142339570.3256@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jan Engelhardt (jengelh@linux01.gwdg.de) wrote:
> the following patch adds a post_setgid() security hook, and necessary dummy 
> funcs.

why?
