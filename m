Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbUAXVqJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 16:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbUAXVqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 16:46:08 -0500
Received: from dp.samba.org ([66.70.73.150]:27813 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262128AbUAXVqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 16:46:07 -0500
Date: Sun, 25 Jan 2004 08:45:05 +1100
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Audit 2.6 set_pte users
Message-ID: <20040124214505.GS11236@krispykreme>
References: <20040124042225.GO11236@krispykreme> <20040124131755.5336c8a5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040124131755.5336c8a5.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I was hoping this might fix the "missing TLB flush" which Martin
> Schwidefsky believes is there, and which is causing him grief.
...
> There is no missing flush here.

Oops, I only parsed one goto deep. Nice how it jumps all over the damn
place.

Anton
