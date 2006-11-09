Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754456AbWKIIOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754456AbWKIIOx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 03:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754460AbWKIIOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 03:14:52 -0500
Received: from hera.kernel.org ([140.211.167.34]:13806 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1754456AbWKIIOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 03:14:52 -0500
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Olivier Nicolas <olivn@trollprod.org>
Subject: Re: 2.6.19-rc5 x86_64  irq 22: nobody cared
Date: Thu, 9 Nov 2006 03:17:27 -0500
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <4551D12D.4010304@trollprod.org>
In-Reply-To: <4551D12D.4010304@trollprod.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611090317.27738.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 November 2006 07:44, Olivier Nicolas wrote:
> Hi,
> 
> 2.6.19-rc5 does not boot properly, I have tried pci=routeirq, irpoll 
> without success.

Still a problem with pci=nomsi removing all those MSI NICs  from the picture?
pci=nommconf is also popular these days:-)

-Len

