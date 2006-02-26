Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWBZTj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWBZTj0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 14:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWBZTj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 14:39:26 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:24207 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751314AbWBZTjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 14:39:25 -0500
Subject: Re: old radeon latency problem still unfixed?
From: Lee Revell <rlrevell@joe-job.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Dave Airlie <airlied@linux.ie>
In-Reply-To: <1140947860.2934.12.camel@laptopd505.fenrus.org>
References: <1140917787.24141.78.camel@mindpipe>
	 <20060226014437.327b1cc3.akpm@osdl.org>
	 <1140947860.2934.12.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Sun, 26 Feb 2006 14:39:23 -0500
Message-Id: <1140982763.24141.123.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-26 at 10:57 +0100, Arjan van de Ven wrote:
> lock_kernel() is a semaphore nowadays.... unless those people just
> turned that off, at which point.. their problem ;)
> 

Thanks I will check on this.

Lee

