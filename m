Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271353AbUJVPKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271353AbUJVPKV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 11:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271338AbUJVPI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 11:08:58 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:43917 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S271335AbUJVPIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 11:08:30 -0400
Date: Fri, 22 Oct 2004 08:08:13 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andrew Morton <akpm@osdl.org>
cc: kenneth.w.chen@intel.com, wli@holomorphy.com, raybry@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V1 [3/4]: Overcommit handling
In-Reply-To: <20041022032823.215bd95f.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0410220807000.7868@schroedinger.engr.sgi.com>
References: <B05667366EE6204181EABE9C1B1C0EB501F2ADFB@scsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.58.0410212151310.3524@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0410212157280.3524@schroedinger.engr.sgi.com>
 <20041022032823.215bd95f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004, Andrew Morton wrote:

> Christoph Lameter <clameter@sgi.com> wrote:
> >
> >  	* overcommit handling
>
> What does this do, and why do we want it?

It was posted with that explanation by Ken. Will look at it and clarify
its purpose for the second round.
