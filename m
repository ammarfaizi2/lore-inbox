Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030440AbVKCS5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030440AbVKCS5J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 13:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030442AbVKCS5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 13:57:09 -0500
Received: from wirelesslogix.com ([209.18.121.242]:21773 "EHLO
	mailrelay.wirelesslogixgroup.com") by vger.kernel.org with ESMTP
	id S1030445AbVKCS5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 13:57:07 -0500
From: Andi Kleen <ak@suse.de>
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: Re: amd64 bitops fix for -Os
Date: Thu, 3 Nov 2005 19:55:26 +0100
User-Agent: KMail/1.8
Cc: Alexandre Oliva <aoliva@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
References: <orvezggf7x.fsf@livre.oliva.athome.lsd.ic.unicamp.br> <4366533C.1010809@linux.intel.com>
In-Reply-To: <4366533C.1010809@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511031955.26580.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 October 2005 18:24, Randy Dunlap wrote:

> Possibly Andrew or Andi have already merged this into their trees.
> However, I have a few comments on the patch re Linux style.
> They are meant to help inform you and others -- that's all.

I have it in my queue, modulo the ugly BUG_ONs.

-Andi
