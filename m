Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161470AbWHJQxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161470AbWHJQxz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161459AbWHJQxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:53:54 -0400
Received: from ns1.suse.de ([195.135.220.2]:39139 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161455AbWHJQxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:53:53 -0400
From: Andi Kleen <ak@suse.de>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: Re: [PATCH 7/14] Generic ioremap_page_range: i386 conversion
Date: Thu, 10 Aug 2006 18:53:46 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
References: <1155225826761-git-send-email-hskinnemoen@atmel.com> <11552258272265-git-send-email-hskinnemoen@atmel.com> <11552258271169-git-send-email-hskinnemoen@atmel.com>
In-Reply-To: <11552258271169-git-send-email-hskinnemoen@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608101853.47003.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 August 2006 18:03, Haavard Skinnemoen wrote:
> From: Andi Kleen <ak@suse.de>

Hmm? I didn't write this patch. 
 
> Convert i386 to use generic ioremap_page_range()

-Andi

 
> Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
> Acked-by: Andi Kleen <ak@suse.de>
