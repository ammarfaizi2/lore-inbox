Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263636AbTKFPXM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 10:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbTKFPXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 10:23:12 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:56747 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263636AbTKFPXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 10:23:11 -0500
Date: Thu, 06 Nov 2003 07:21:23 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: agl@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [RFC] Smarter stack traces using the frame pointer
Message-ID: <48670000.1068132081@[10.10.2.4]>
In-Reply-To: <20031106225101.33e15a48.sfr@canb.auug.org.au>
References: <1067984031.544.23.camel@agtpad><20031105132138.59326dd4.sfr@canb.auug.org.au><119200000.1068062194@flay> <20031106225101.33e15a48.sfr@canb.auug.org.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> What's the difference between the two patches, apart from the size?
>> Better error handling / functionality somehow? 
> 
> I think mine handles more cases, but is much more of a hack ...

I don't care if it's a hack, as long as it works ;-) Could you elaborate
on the other cases it handles?

Thanks,

M.

