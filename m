Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWDUGlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWDUGlU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 02:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWDUGlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 02:41:20 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:16053 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751199AbWDUGlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 02:41:19 -0400
Date: Fri, 21 Apr 2006 09:41:15 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Alasdair G Kergon <agk@redhat.com>
cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] Device-mapper snapshot metadata userspace breakage
In-Reply-To: <20060420173717.GI24520@agk.surrey.redhat.com>
Message-ID: <Pine.LNX.4.58.0604210938390.29821@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0604201159350.29821@sbz-30.cs.Helsinki.FI>
 <20060420173717.GI24520@agk.surrey.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2006, Alasdair G Kergon wrote:
> > lvm2  2.01.04-5
> > device-mapper 1.01.00-4
> 
> Upgrade!

Not in Debian stable, so I guess we'll need to downgrade. That's too bad 
for all of us because now we have one less tester for new kernels. Oh 
well..

				Pekka
