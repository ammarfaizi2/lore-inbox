Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262537AbUJ0RMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262537AbUJ0RMb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 13:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbUJ0RLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 13:11:53 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:54480 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262522AbUJ0Q1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 12:27:09 -0400
Date: Wed, 27 Oct 2004 09:25:50 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: David Gibson <david@gibson.dropbear.id.au>
cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V2 [0/8]: Discussion and overview
In-Reply-To: <20041027052317.GG1676@zax>
Message-ID: <Pine.LNX.4.58.0410270925350.17538@schroedinger.engr.sgi.com>
References: <B05667366EE6204181EABE9C1B1C0EB504BFA47C@scsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.58.0410251825020.12962@schroedinger.engr.sgi.com>
 <20041027052317.GG1676@zax>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004, David Gibson wrote:

> I wish we could start calling this "lazy allocation" instead of
> "demand paging".  "Demand paging" makes people think of swapping
> hugepages, or mapping files on real filesystems with hugepages, which
> is not what these patches do, and probably something we don't want to
> do.

Good idea.

