Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267645AbUJLTeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267645AbUJLTeQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 15:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267659AbUJLTeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 15:34:15 -0400
Received: from ozlabs.org ([203.10.76.45]:15237 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267645AbUJLTeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 15:34:05 -0400
Date: Wed, 13 Oct 2004 05:33:40 +1000
From: Anton Blanchard <anton@samba.org>
To: Rik van Riel <riel@redhat.com>
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, linux-mm@kvack.org
Subject: Re: NUMA: Patch for node based swapping
Message-ID: <20041012193340.GA3315@krispykreme.ozlabs.ibm.com>
References: <Pine.LNX.4.58.0410120751010.11558@schroedinger.engr.sgi.com> <Pine.LNX.4.44.0410121126390.13693-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0410121126390.13693-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> That sounds like an extraordinarily bad idea for eg. AMD64
> systems, which have a very low numa factor.

Same with ppc64.

Anton
