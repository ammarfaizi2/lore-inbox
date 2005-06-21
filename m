Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262226AbVFUSrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbVFUSrM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 14:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbVFUSrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 14:47:12 -0400
Received: from ns.suse.de ([195.135.220.2]:25509 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262226AbVFUSrE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 14:47:04 -0400
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] Integrate AIO with wait-bit based filtered wakeups
References: <20050620120154.GA4810@in.ibm.com.suse.lists.linux.kernel>
	<20050620160126.GA5271@in.ibm.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 21 Jun 2005 20:46:59 +0200
In-Reply-To: <20050620160126.GA5271@in.ibm.com.suse.lists.linux.kernel>
Message-ID: <p73slzbbl98.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> writes:
> 
> All in all, these changes have (hopefully) simplified the code,
> as well as made it more up-to-date. Comments (including
> better names etc as requested by Zach) are welcome !

I looked over the patches and they look all fine to me.

-Andi
