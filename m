Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbULLUYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbULLUYN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 15:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbULLUXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 15:23:17 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:47747 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S262123AbULLUVV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 15:21:21 -0500
Date: Sun, 12 Dec 2004 15:21:35 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove unused
Message-ID: <20041212202135.GE25788@fieldses.org>
References: <20041212195047.GH22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041212195047.GH22324@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2004 at 08:50:47PM +0100, Adrian Bunk wrote:
> I wasn't able to find any usage of this file (it seems the 
> EXPORT_SYMBOL's were moved away, but deleting the filw was forgotten).

Yep.--b.
