Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbWEEJCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWEEJCk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 05:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWEEJCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 05:02:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:7358 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750955AbWEEJCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 05:02:38 -0400
From: Andi Kleen <ak@suse.de>
To: "Ayaz Abdulla" <AAbdulla@nvidia.com>
Subject: Re: pci_enable_msix throws up error
Date: Fri, 5 May 2006 10:44:25 +0200
User-Agent: KMail/1.9.1
Cc: ravinandan.arakali@neterion.com, linux-kernel@vger.kernel.org,
       "Ananda. Raju" <ananda.raju@neterion.com>, netdev@vger.kernel.org,
       "Leonid Grossman" <Leonid.Grossman@neterion.com>
References: <DBFABB80F7FD3143A911F9E6CFD477B00BA5E264@hqemmail02.nvidia.com>
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B00BA5E264@hqemmail02.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605051044.25646.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 May 2006 07:14, Ayaz Abdulla wrote:
> I noticed the same behaviour, i.e. can not use both MSI and MSIX without
> rebooting.
> 
> I had sent a message to the maintainer of the MSI/MSIX source a few
> months ago and got a response that they were working on fixing it. Not
> sure what the progress is on it.

The best way to make progress faster would be for someone like you
who needs it to submit a patch to fix it then.

-Andi
