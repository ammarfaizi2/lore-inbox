Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWHRLJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWHRLJW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 07:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWHRLJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 07:09:22 -0400
Received: from ns.suse.de ([195.135.220.2]:31369 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751364AbWHRLJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 07:09:21 -0400
From: Andi Kleen <ak@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] kill default_ldt
Date: Fri, 18 Aug 2006 14:16:17 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <44E59E05.4070804@goop.org>
In-Reply-To: <44E59E05.4070804@goop.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608181416.18106.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 August 2006 13:01, Jeremy Fitzhardinge wrote:
> The default LDT is completely unused now that iBCS is no longer
> supported, so get rid of it.

Thanks, looks good.

-Andi
