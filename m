Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266938AbUBGPJH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 10:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266929AbUBGPJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 10:09:07 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:9319 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S266938AbUBGPJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 10:09:05 -0500
Date: Sat, 7 Feb 2004 10:08:27 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Michael Frank <mhf@linuxmail.org>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, <axboe@suse.de>,
       <rddunlap@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.25-rc1: Add user friendliness to highmem= option
In-Reply-To: <200402071950.53386.mhf@linuxmail.org>
Message-ID: <Pine.LNX.4.44.0402071007510.28464-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Feb 2004, Michael Frank wrote:

> Enclosed is a patch for x86 to make highmem= option easier to use.
> 
> - Automates alignment of highmem zone
> - Fixes invalid highmem settings whether too small or to large
> - Adds entry in kernel-parameters.txt

This is awesome!  Thanks.

Marcelo, could you please apply this ? ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

