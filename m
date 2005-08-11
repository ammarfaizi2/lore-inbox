Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbVHKQjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbVHKQjn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 12:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbVHKQjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 12:39:43 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:21664 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1751109AbVHKQjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 12:39:42 -0400
Message-ID: <42FB7F4F.80507@zabbo.net>
Date: Thu, 11 Aug 2005 09:39:43 -0700
From: Zach Brown <zab@zabbo.net>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Pekka J Enberg <penberg@cs.Helsinki.FI>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       David Teigland <teigland@redhat.com>, Pekka Enberg <penberg@gmail.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com,
       Andreas Dilger <adilger@clusterfs.com>
Subject: Re: GFS
References: <Pine.LNX.4.58.0508111006470.13379@sbz-30.cs.Helsinki.FI> <42FB7DE5.2080506@zabbo.net> <20050811163541.GA4351@infradead.org>
In-Reply-To: <20050811163541.GA4351@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That doesn't matter.  Please don't put in any effort for lustre special
> cases - they are unwilling to cooperate and they'll get what they deserve.

Sure, we can add that extra functional layer in another pass.  I thought
I'd still bring it up, though, as OCFS2 is slated to care at some point
in the not too distant future.

> Sure, I'm not sure that'll happen in a timely fashion, though.

Roger.

- z
