Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbUKCVwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbUKCVwc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 16:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbUKCVuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 16:50:13 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:16125 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261878AbUKCVpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 16:45:31 -0500
Date: Wed, 3 Nov 2004 13:45:14 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       urban@teststation.com
Subject: Re: [PATCH 2.6.10-rc1] Fix building of samba userland
Message-ID: <20041103214514.GA13549@taniwha.stupidest.org>
References: <20041103190345.GI381@smtp.west.cox.net> <20041103205548.GA10756@taniwha.stupidest.org> <20041103213210.GJ381@smtp.west.cox.net> <20041103213303.GA13459@taniwha.stupidest.org> <20041103214218.GK381@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041103214218.GK381@smtp.west.cox.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 02:42:18PM -0700, Tom Rini wrote:

> I would guess they don't get 'smbmount'.

oh, i didn't realize it was for that...  well, yes, that is a tough
one.  i wonder why that code doesnt' get merged into Linux's mount(8)
though?
