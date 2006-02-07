Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbWBGTjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbWBGTjV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 14:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965168AbWBGTjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 14:39:21 -0500
Received: from ns1.suse.de ([195.135.220.2]:2258 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965167AbWBGTjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 14:39:20 -0500
From: Andi Kleen <ak@suse.de>
To: ltuikov@yahoo.com
Subject: Re: [PATCH] x86-64: improve the format of stack dumps
Date: Tue, 7 Feb 2006 20:39:02 +0100
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, rdunlap@xenotime.net, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
References: <20060207191717.25539.qmail@web31804.mail.mud.yahoo.com>
In-Reply-To: <20060207191717.25539.qmail@web31804.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602072039.03261.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 February 2006 20:17, Luben Tuikov wrote:

> 
> As to "less space", this patch prints _identical_ information as the code
> before it, as I'm sure you can see by reading the patch itself.

It prints basically the same information in more screen space, which is 
a regression.

-Andi
