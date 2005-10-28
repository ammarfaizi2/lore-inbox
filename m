Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030188AbVJ1Obh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbVJ1Obh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 10:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbVJ1Obh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 10:31:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43935 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030188AbVJ1Obg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 10:31:36 -0400
Date: Fri, 28 Oct 2005 07:31:27 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Greg K-H <greg@kroah.com>, gregkh@suse.de, linux-kernel@vger.kernel.org,
       david-b@pacbell.net
Subject: Re: [PATCH] pci device wakeup flags
In-Reply-To: <20051028035116.112ba2ca.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0510280730450.4664@g5.osdl.org>
References: <11304810221338@kroah.com> <11304810223093@kroah.com>
 <20051028035116.112ba2ca.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 28 Oct 2005, Andrew Morton wrote:
> 
> This is the patch which I've been religiously dropping from -mm because it
> kills my Mac G5.  What are we doing merging this?

Well, since my main machine is a Mac G5, we certainly /aren't/ merging it 
if it kills it.

		Linus
