Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVCACr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVCACr3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 21:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVCACr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 21:47:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24271 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261218AbVCACrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 21:47:25 -0500
Date: Tue, 1 Mar 2005 02:47:21 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Adrian Bunk <bunk@stusta.de>
Cc: matthew@wil.cx, James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/scsi/sym53c8xx_2/sym_hipd.c: make a function static
Message-ID: <20050301024721.GD28741@parcelfarce.linux.theplanet.co.uk>
References: <20050228220155.GS4021@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050228220155.GS4021@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2005 at 11:01:55PM +0100, Adrian Bunk wrote:
> This patch makes a needlessly global function static.

Thanks, committed

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
