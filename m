Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030488AbVI3Wqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030488AbVI3Wqf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 18:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030492AbVI3Wqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 18:46:35 -0400
Received: from ns1.suse.de ([195.135.220.2]:53199 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030488AbVI3Wqf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 18:46:35 -0400
From: Andi Kleen <ak@suse.de>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [Patch] x86, x86_64: fix cpu model for family 0x6
Date: Sat, 1 Oct 2005 00:46:48 +0200
User-Agent: KMail/1.8
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
References: <20050929190419.C15943@unix-os.sc.intel.com> <200510010002.16382.ak@suse.de> <20050930152358.D28092@unix-os.sc.intel.com>
In-Reply-To: <20050930152358.D28092@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510010046.48964.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 01 October 2005 00:23, Siddha, Suresh B wrote:

> And also you have a typo. It should be 0x6.

Fixed.

> Anyhow, I prefer my second patch.

It doesn't even apply - you patched x86_64/kernel/setup.c twice.

-Andi
