Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268248AbUHFTfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268248AbUHFTfm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 15:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268253AbUHFTeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 15:34:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12214 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268248AbUHFTdE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 15:33:04 -0400
Date: Fri, 6 Aug 2004 20:31:18 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Phillip Lougher <phillip@lougher.demon.co.uk>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] VFS readahead bug in 2.6.8-rc[1-3]
Message-ID: <20040806193118.GT12308@parcelfarce.linux.theplanet.co.uk>
References: <41127371.1000603@lougher.demon.co.uk> <4112D6FD.4030707@yahoo.com.au> <4112EAAB.8040005@yahoo.com.au> <4113B8A2.4050609@lougher.demon.co.uk> <4113D4CD.5080109@yahoo.com.au> <4113D8AF.5030803@lougher.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4113D8AF.5030803@lougher.demon.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 08:14:55PM +0100, Phillip Lougher wrote:
> Point one: The interface didn't do this UNTIL you changed the code
> Point two: Just because no one has reported other filesystem
> breakage, it doesn't mean other filesystems have not broken.

Point three: it was never promised *AND* never intended.
