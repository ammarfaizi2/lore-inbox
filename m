Return-Path: <linux-kernel-owner+w=401wt.eu-S1422686AbXAETPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422686AbXAETPq (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 14:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422687AbXAETPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 14:15:46 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:38373 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1422686AbXAETPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 14:15:45 -0500
Date: Fri, 5 Jan 2007 11:15:29 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Robert Hancock <hancockr@shaw.ca>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.20-rc3-git4 oops on suspend: __drain_pages
In-Reply-To: <459DB116.9070805@shaw.ca>
Message-ID: <Pine.LNX.4.64.0701051114200.28395@schroedinger.engr.sgi.com>
References: <459DB116.9070805@shaw.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2007, Robert Hancock wrote:

> Saw this oops on 2.6.20-rc3-git4 when attempting to suspend. This only
> happened in 1 of 3 attempts.

See the fix that I posted yesterday to linux-mm. Its now in Andrew's tree.
