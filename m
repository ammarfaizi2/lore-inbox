Return-Path: <linux-kernel-owner+w=401wt.eu-S1751290AbXAUR5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbXAUR5M (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 12:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbXAUR5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 12:57:12 -0500
Received: from alnrmhc11.comcast.net ([204.127.225.91]:38161 "EHLO
	alnrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbXAUR5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 12:57:11 -0500
X-Greylist: delayed 337 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jan 2007 12:57:11 EST
Subject: Re: [PATCH] Introduce simple TRUE and FALSE boolean macros.
From: Nicholas Miell <nmiell@comcast.net>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, linville@tuxdriver.com
In-Reply-To: <Pine.LNX.4.64.0701210454590.2844@CPE00045a9c397f-CM001225dbafb6>
References: <Pine.LNX.4.64.0701210454590.2844@CPE00045a9c397f-CM001225dbafb6>
Content-Type: text/plain
Date: Sun, 21 Jan 2007 09:51:32 -0800
Message-Id: <1169401892.2999.1.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2007-01-21 at 05:03 -0500, Robert P. J. Day wrote:
>   Introduce the TRUE and FALSE boolean macros so that everyone can
> stop re-inventing them, and remove the one occurrence in the source
> tree that clashes with that change.
> 

If you're going to introduce true and false macros, you should probably
use the official all-lowercase C99 version.

-- 
Nicholas Miell <nmiell@comcast.net>

