Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266048AbUBGUmm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 15:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266018AbUBGUml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 15:42:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44213 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265838AbUBGUl6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 15:41:58 -0500
Date: Sat, 7 Feb 2004 20:41:56 +0000
From: Matthew Wilcox <willy@debian.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Gerard Roudier <groudier@free.fr>, matthew@wil.cx,
       linux-scsi@vger.kernel.org, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] sym53c8xx_2: warning: "BYTE_ORDER" is not defined
Message-ID: <20040207204156.GZ24334@parcelfarce.linux.theplanet.co.uk>
References: <20040207190051.GN26093@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040207190051.GN26093@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 07, 2004 at 08:00:51PM +0100, Adrian Bunk wrote:
> Hi,
> 
> when compiling 2.6.2-mm1 (this problem doesn't seem to be specific
> to -mm)) with -Wundef I got many of the following warnings:

Thanks for the patch; I've taken it into my tree.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
