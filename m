Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264409AbUFPSVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264409AbUFPSVl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 14:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264405AbUFPSVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 14:21:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32986 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264375AbUFPSVc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 14:21:32 -0400
Date: Wed, 16 Jun 2004 19:21:31 +0100
From: Matthew Wilcox <willy@debian.org>
To: Vladislav Bolkhovitin <vst@vlnb.net>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [ANNOUNCE] Generic SCSI Target Middle Level for Linux (SCST) with target drivers
Message-ID: <20040616182131.GV20511@parcelfarce.linux.theplanet.co.uk>
References: <40D075DA.2000007@vlnb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D075DA.2000007@vlnb.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 08:31:22PM +0400, Vladislav Bolkhovitin wrote:
> Any comments would be appreciated.

The first obvious question is: Why does this need to be done in kernel
space?  My impression was that an iSCSI target would best be done in
userspace.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
