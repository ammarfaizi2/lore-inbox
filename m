Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbWAIU2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWAIU2U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 15:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWAIU2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 15:28:20 -0500
Received: from mail.suse.de ([195.135.220.2]:48323 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751279AbWAIU2T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 15:28:19 -0500
From: Andi Kleen <ak@suse.de>
To: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
Subject: Re: [patch 2/2] add x86-64 support for memory hot-add
Date: Mon, 9 Jan 2006 21:27:07 +0100
User-Agent: KMail/1.8.2
Cc: "Matt Tolentino" <metolent@cs.vt.edu>, akpm@osdl.org, discuss@x86-64.org,
       kmannth@us.ibm.com, linux-kernel@vger.kernel.org
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB00C0B777A@fmsmsx406.amr.corp.intel.com>
In-Reply-To: <D36CE1FCEFD3524B81CA12C6FE5BCAB00C0B777A@fmsmsx406.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601092127.07627.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 January 2006 20:55, Tolentino, Matthew E wrote:

> I've looked at it in the past, but haven't pursued it to 
> date, nor have I quantified the work involved.
> The reason for the this approach thus far has been to 
> enable machines that support hot-add today...which are 
> non-NUMA.  

Yes, but they'll be likely running NUMA kernels.

-Andi
