Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262796AbVCJRgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbVCJRgB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 12:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262791AbVCJRcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 12:32:55 -0500
Received: from extgw-uk.mips.com ([62.254.210.129]:44310 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S262938AbVCJR3O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 12:29:14 -0500
Date: Thu, 10 Mar 2005 17:28:40 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Panagiotis Issaris <panagiotis.issaris@mech.kuleuven.ac.be>
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] qtronix missing failure handling
Message-ID: <20050310172840.GD26269@linux-mips.org>
References: <20050305150844.GA7544@mech.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050305150844.GA7544@mech.kuleuven.ac.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2005 at 04:08:44PM +0100, Panagiotis Issaris wrote:

> Hi,
> 
> The Qtronix keyboard driver doesn't handle the possible failure of memory
> allocation.

Thanks, applied.

Please copy Linux/MIPS-specific patches to me or linux-mips@linux-mips.org;
it was more a coincidence that I noticed your patch on this list.

Thanks,

  Ralf
