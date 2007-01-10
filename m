Return-Path: <linux-kernel-owner+w=401wt.eu-S932586AbXAJAbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586AbXAJAbG (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 19:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbXAJAbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 19:31:06 -0500
Received: from ns2.suse.de ([195.135.220.15]:56405 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932586AbXAJAbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 19:31:05 -0500
From: Andi Kleen <ak@suse.de>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [PATCH 1/4] MMCONFIG: cleanup
Date: Wed, 10 Jan 2007 01:21:13 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@linux.intel.com>
References: <878xgc58nc.fsf@duaron.myhome.or.jp>
In-Reply-To: <878xgc58nc.fsf@duaron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701100121.14123.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 January 2007 19:59, OGAWA Hirofumi wrote:
> This just cleans up.

The mmconfig code has completely changed in -mm/x86_64 soon. Can you resubmit against 
that please?

-Andi
