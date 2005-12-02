Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbVLBRHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbVLBRHV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 12:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbVLBRHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 12:07:21 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:9177 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750825AbVLBRHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 12:07:19 -0500
Date: Fri, 2 Dec 2005 11:06:38 -0600
From: Jon Mason <jdmason@us.ibm.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Grover <andrew.grover@intel.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, john.ronciak@intel.com,
       christopher.leech@intel.com
Subject: Re: [RFC] [PATCH 0/3] ioat: DMA engine support
Message-ID: <20051202170638.GA1443@us.ibm.com>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Andrew Grover <andrew.grover@intel.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, john.ronciak@intel.com,
	christopher.leech@intel.com
References: <Pine.LNX.4.44.0511231143380.32487-100000@isotope.jf.intel.com> <4384F110.4060908@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4384F110.4060908@pobox.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 05:45:36PM -0500, Jeff Garzik wrote:
> Andrew Grover wrote:
> >As presented in our talk at this year's OLS, the Bensley platform, which 
> >will be out in early 2006, will have an asyncronous DMA engine. It can be 
> >used to offload copies from the CPU, such as the kernel copies of received 
> >packets into the user buffer.
> 
> More than a one-paragraph description would be nice...  URLs to OLS and 
> IDF presentations, other info?
> 
> 	Jeff
> 
FYI,
OLS paper can be found at
http://www.linuxsymposium.org/2005/linuxsymposium_procv1.pdf
Starting at page 281.

Other info can be found at
http://www.intel.com/technology/ioacceleration/index.htm
