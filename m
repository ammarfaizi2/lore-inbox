Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVAXNJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVAXNJb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 08:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbVAXNJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 08:09:31 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:10122 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261350AbVAXNJ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 08:09:29 -0500
Subject: Re: [2.6 patch] drivers/char/moxa.c: #if 0 an unused function
From: Josh Boyer <jdub@us.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050123101743.GM3212@stusta.de>
References: <20050123101743.GM3212@stusta.de>
Content-Type: text/plain
Message-Id: <1106572166.6955.0.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 24 Jan 2005 07:09:27 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-01-23 at 04:17, Adrian Bunk wrote:
> This patch #if 0's an unused global function.

Ugh, why?  Why not just remove it if it's unused?

josh

