Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVCUAyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVCUAyZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 19:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVCUAyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 19:54:25 -0500
Received: from graphe.net ([209.204.138.32]:54281 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261413AbVCUAyX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 19:54:23 -0500
Date: Sun, 20 Mar 2005 16:54:21 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: Andrew Morton <akpm@osdl.org>
cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] del_timer_sync scalability patch
In-Reply-To: <20050320153446.32a9215a.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0503201653310.2250@server.graphe.net>
References: <200503202319.j2KNJXg29946@unix-os.sc.intel.com>
 <20050320153446.32a9215a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Mar 2005, Andrew Morton wrote:

> > Hope Andrew is going to take the patch this time.
>
> Hope Kenneth is going to test the alternate del_timer_sync patches in next
> -mm ;)

BTW Why are we going through this? Oleg has posted a much better solution
to this issue yersteday AFAIK.
