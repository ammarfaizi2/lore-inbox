Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbVBQOv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbVBQOv3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 09:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbVBQOvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 09:51:17 -0500
Received: from duempel.org ([81.209.165.42]:23424 "HELO swift.roonstrasse.net")
	by vger.kernel.org with SMTP id S262182AbVBQOs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 09:48:58 -0500
Date: Thu, 17 Feb 2005 15:48:53 +0100
From: Max Kellermann <max@duempel.org>
To: "Fao, Sean" <sean.fao@capitalgenomix.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Netfilter: TARPIT Target
Message-ID: <20050217144853.GA1468@roonstrasse.net>
Mail-Followup-To: "Fao, Sean" <sean.fao@capitalgenomix.com>,
	linux-kernel@vger.kernel.org
References: <4214AD2B.7020607@capitalgenomix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4214AD2B.7020607@capitalgenomix.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005/02/17 15:41, "Fao, Sean" <sean.fao@capitalgenomix.com> wrote:
> I wanted to use the TARPIT target provided by Netfilter, but I am unable 
> to find the module in the kernel.  Has it been removed or am I looking 
> in the wrong place?

It is not in the mainstream kernel yet. You can find it in
netfilter patch-o-matic:

 http://ftp.netfilter.org/pub/patch-o-matic-ng/snapshot/

Max

