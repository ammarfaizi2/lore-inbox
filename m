Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262229AbVFUTD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262229AbVFUTD6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 15:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbVFUTD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 15:03:58 -0400
Received: from holomorphy.com ([66.93.40.71]:4060 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262229AbVFUTD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 15:03:57 -0400
Date: Tue, 21 Jun 2005 12:03:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org, bcrl@kvack.org,
       zab@zabbo.net, mason@suse.com, ysaito@hpl.hp.com
Subject: Re: Pending AIO work/patches
Message-ID: <20050621190338.GA10690@holomorphy.com>
References: <20050620120154.GA4810@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050620120154.GA4810@in.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 05:31:54PM +0530, Suparna Bhattacharya wrote:
> Since AIO development is gaining momentum once again, ocfs2 and
> samba both appear to be using AIO, NFS needs async semaphores etc,
> there appears to be an increase in interest in straightening out some
> of the pending work in this area. So this seems like a good
> time to re-post some of those patches for discussion and decision.
> Just to help sync up, here is an initial list based on the pieces
> that have been in progress with patches in existence (please feel free
> to add/update ones I missed or reflected inaccurately here):

I'm going to keep going over these until I get tired of it for general
bulletproofing purposes, but all indications thus far are good.


-- wli
