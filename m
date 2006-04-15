Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965183AbWDOXBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965183AbWDOXBQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 19:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbWDOXBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 19:01:16 -0400
Received: from mx2.netapp.com ([216.240.18.37]:12431 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S932515AbWDOXBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 19:01:14 -0400
X-IronPort-AV: i="4.04,122,1144047600"; 
   d="scan'208"; a="374753575:sNHT364917764"
User-Agent: Microsoft-Entourage/11.2.3.060209
Date: Sat, 15 Apr 2006 19:01:06 -0400
Subject: Re: [NFS] [RFC: 2.6 patch] net/sunrpc/: possible cleanups
From: "Lever, Charles" <Charles.Lever@netapp.com>
To: Adrian Bunk <bunk@stusta.de>
CC: David Miller <davem@davemloft.net>, <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       <nfs@lists.sourceforge.net>, <netdev@vger.kernel.org>
Message-ID: <C066F372.7D70%Charles.Lever@netapp.com>
Thread-Topic: [NFS] [RFC: 2.6 patch] net/sunrpc/: possible cleanups
Thread-Index: AcZg4HnbuDsOuszTEdqhAQAUUaklgA==
In-Reply-To: <20060415213215.GN15022@stusta.de>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
X-OriginalArrivalTime: 15 Apr 2006 23:01:07.0607 (UTC) FILETIME=[7AD09A70:01C660E0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/06 5:32 PM, "Adrian Bunk" <bunk@stusta.de> wrote:

> On Thu, Oct 06, 2005 at 07:13:14AM -0700, Lever, Charles wrote:
> 
>> actually, can we hold off on this change?  the RPC transport switch will
>> eventually need most of those EXPORT_SYMBOLs.
>> ...
>>> This patch was already sent on:
>>> - 30 May 2005
>>> - 7 May 2005
>> ...
> 
> One year has passed since I sent this patch the first time, and with the
> exception that it needs re-diff'ing it still applies.
> 
> Charles, are the changes you are talking about that might need them
> available in the very near future?

Yes, they are coming soon.
