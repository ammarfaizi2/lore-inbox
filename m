Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261894AbUKCVtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbUKCVtL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 16:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbUKCVpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 16:45:16 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:44522 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261878AbUKCVmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 16:42:19 -0500
Date: Wed, 3 Nov 2004 14:42:18 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       urban@teststation.com
Subject: Re: [PATCH 2.6.10-rc1] Fix building of samba userland
Message-ID: <20041103214218.GK381@smtp.west.cox.net>
References: <20041103190345.GI381@smtp.west.cox.net> <20041103205548.GA10756@taniwha.stupidest.org> <20041103213210.GJ381@smtp.west.cox.net> <20041103213303.GA13459@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041103213303.GA13459@taniwha.stupidest.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 01:33:03PM -0800, Chris Wedgwood wrote:
> On Wed, Nov 03, 2004 at 02:32:10PM -0700, Tom Rini wrote:
> 
> > Digging around a bit, it needs SMB_CASE_DEFAULT (enum) and
> > SMB_IOC_NEWCONN.
> 
> where does this come from for non-Linux platforms?

I would guess they don't get 'smbmount'.

-- 
Tom Rini
http://gate.crashing.org/~trini/
