Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262094AbVD1Mz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbVD1Mz1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 08:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbVD1Mz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 08:55:26 -0400
Received: from gate.in-addr.de ([212.8.193.158]:51413 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S262094AbVD1MzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 08:55:22 -0400
Date: Thu, 28 Apr 2005 14:21:47 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1a/7] dlm: core locking
Message-ID: <20050428122147.GO21645@marowsky-bree.de>
References: <20050425165705.GA11938@redhat.com> <20050427214136.GC938@ca-server1.us.oracle.com> <200504272241.04254.phillips@istop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504272241.04254.phillips@istop.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-04-27T22:41:04, Daniel Phillips <phillips@istop.com> wrote:

> > Just a couple comments here, more will come as time permits. I know you
> > consider cluster file systems to be "obscure" apps...
> Oh the contrary, cluster filesystems are the main focus of and reason for the 
> current submission.

He was actually quoting David. And indeed it is very important that the
DLM interfaces be generally useful, not just for a specific cluster
filesystem; if that was the goal, it would be an internal component only
and no need to expose it.


-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business

