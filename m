Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbVHCKjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbVHCKjL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 06:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbVHCKjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 06:39:09 -0400
Received: from gate.in-addr.de ([212.8.193.158]:20897 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S262215AbVHCKhu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 06:37:50 -0400
Date: Wed, 3 Aug 2005 12:37:44 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: David Teigland <teigland@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: [PATCH 00/14] GFS
Message-ID: <20050803103744.GG11081@marowsky-bree.de>
References: <20050802071828.GA11217@redhat.com> <1122968724.3247.22.camel@laptopd505.fenrus.org> <20050803035618.GB9812@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803035618.GB9812@redhat.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-08-03T11:56:18, David Teigland <teigland@redhat.com> wrote:

> > * Why use your own journalling layer and not say ... jbd ?
> Here's an analysis of three approaches to cluster-fs journaling and their
> pros/cons (including using jbd):  http://tinyurl.com/7sbqq

Very instructive read, thanks for the link.



-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

