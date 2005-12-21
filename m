Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbVLUTU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbVLUTU4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 14:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbVLUTU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 14:20:56 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:12257 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751205AbVLUTUz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 14:20:55 -0500
Date: Wed, 21 Dec 2005 19:20:54 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] handle module ref count on sysctl tables.
Message-ID: <20051221192054.GN27946@ftp.linux.org.uk>
References: <20051221103520.258ced08@dxpl.pdx.osdl.net> <20051221190849.GM27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051221190849.GM27946@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 07:08:49PM +0000, Al Viro wrote:
> Solution is fairly simple:

Just to clarify: said solution is already in the tree...
