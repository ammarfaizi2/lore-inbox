Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266177AbUGETIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266177AbUGETIh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 15:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266179AbUGETIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 15:08:37 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:45055 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S266177AbUGETIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 15:08:35 -0400
Message-ID: <40E9A722.8020402@nortelnetworks.com>
Date: Mon, 05 Jul 2004 15:08:18 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Phillips <phillips@redhat.com>
CC: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
References: <200407051442.27397.phillips@redhat.com>
In-Reply-To: <200407051442.27397.phillips@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

> Don't you think we ought to take a look at how OCFS and GFS might share
> some of the same infrastructure, for example, the DLM and cluster
> membership services?

For cluster membership, you might consider looking at the OpenAIS CLM portion. 
It would be nice if this type of thing was unified across more than just 
filesystems.

Chris
