Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbUKPCfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbUKPCfs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 21:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbUKPCfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 21:35:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16537 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261760AbUKPCe7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 21:34:59 -0500
Date: Tue, 16 Nov 2004 02:34:58 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Adrian Bunk <bunk@stusta.de>
Cc: matthew@wil.cx, James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] SCSI sym53c8xx_2: make some code static
Message-ID: <20041116023458.GE26623@parcelfarce.linux.theplanet.co.uk>
References: <20041115023712.GD2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041115023712.GD2249@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 03:37:12AM +0100, Adrian Bunk wrote:
> The patch below makes some needlessly global code static.

Thanks, I'll apply this.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
