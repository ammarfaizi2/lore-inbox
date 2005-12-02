Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbVLBEHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbVLBEHE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 23:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbVLBEHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 23:07:04 -0500
Received: from sccrmhc13.comcast.net ([63.240.77.83]:54174 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1751090AbVLBEHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 23:07:03 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] add boot option to control Intel combined mode behavior (to allow DMA in combined mode configs!)
Date: Thu, 1 Dec 2005 20:07:04 -0800
User-Agent: KMail/1.8.92
Cc: linux-kernel@vger.kernel.org
References: <200511282306.38515.jbarnes@virtuousgeek.org> <438CCE0D.7090304@pobox.com> <200511291415.07306.jbarnes@virtuousgeek.org>
In-Reply-To: <200511291415.07306.jbarnes@virtuousgeek.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512012007.04536.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just FYI, I tested this new patch (the one that changes the option from 
intel_combined_mode= to combined_mode=) and it works great.  Please 
push it upstream after 2.6.15 comes out; I think lots of people will 
benefit from being able to turn on DMA.

Thanks,
Jesse
