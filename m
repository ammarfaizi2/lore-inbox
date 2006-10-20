Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbWJTQbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWJTQbB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 12:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWJTQbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 12:31:00 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:64183 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1751028AbWJTQbA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 12:31:00 -0400
Date: Fri, 20 Oct 2006 17:30:58 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Andy Whitcroft <apw@shadowen.org>
Cc: Paul Mackerras <paulus@samba.org>, Christoph Lameter <clameter@sgi.com>,
       Anton Blanchard <anton@samba.org>, akpm@osdl.org,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Mike Kravetz <kravetz@us.ibm.com>
Subject: Re: [PATCH] Reintroduce NODES_SPAN_OTHER_NODES for powerpc
In-Reply-To: <8a76dfd735e544016c5f04c98617b87d@pinky>
Message-ID: <Pine.LNX.4.64.0610201730420.13216@skynet.skynet.ie>
References: <4538DACC.5050605@shadowen.org> <8a76dfd735e544016c5f04c98617b87d@pinky>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006, Andy Whitcroft wrote:

> Reintroduce NODES_SPAN_OTHER_NODES for powerpc
>
> Revert "[PATCH] Remove SPAN_OTHER_NODES config definition"
>    This reverts commit f62859bb6871c5e4a8e591c60befc8caaf54db8c.
> Revert "[PATCH] mm: remove arch independent NODES_SPAN_OTHER_NODES"
>    This reverts commit a94b3ab7eab4edcc9b2cb474b188f774c331adf7.
>
> Also update the comments to indicate that this is still required
> and where its used.
>
> Signed-off-by: Andy Whitcroft <apw@shadowen.org>

Acked-by: Mel Gorman <mel@csn.ul.ie>
