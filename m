Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWEZOVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWEZOVf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 10:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWEZOVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 10:21:35 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:51587 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750774AbWEZOVe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 10:21:34 -0400
Date: Fri, 26 May 2006 09:21:17 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       Mike Halcrow <mhalcrow@us.ibm.com>, Mike Halcrow <mike@halcrow.us>
Subject: [PATCH 0/10] eCryptfs Updates
Message-ID: <20060526142117.GA2764@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set addresses file locking, NULL pointer checks, and fsync
issues that Christoph Hellwig pointed out. There are other remaining
issues that Christoph brought up that require more work; we will be
sending another patch set to address those issues in the near future.

Mike
