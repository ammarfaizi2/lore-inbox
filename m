Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264338AbTE0WTU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 18:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264370AbTE0WTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 18:19:20 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:38925 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264338AbTE0WTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 18:19:19 -0400
Date: Tue, 27 May 2003 23:32:31 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Paul Mackerras <paulus@samba.org>
cc: linux-kernel@vger.kernel.org, <linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] [PATCH] update valkyriefb driver
In-Reply-To: <16079.23215.864277.374639@argo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.44.0305272329560.26160-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> OK, but I haven't been able to test it.  I have simplified the driver
> quite a bit using the knowledge that there can only ever be one
> valkyrie graphics adaptor in a system - it is the built-in graphics
> adaptor on various ancient mac and powermac machines, and we access it
> at a hard-coded address, so we can only handle one.

Applied. 


