Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263453AbTJBTpV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 15:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbTJBTpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 15:45:21 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:60058 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S263453AbTJBTpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 15:45:19 -0400
Date: Thu, 2 Oct 2003 15:45:17 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Brett <brettspamacct@fastclick.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Getting total memory used by processes
In-Reply-To: <3F7C6ABF.8070900@fastclick.com>
Message-ID: <Pine.LNX.4.44.0310021544330.25860-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Oct 2003, Brett wrote:

> I patched the kernel with rmap and i2c,

> # cat /proc/meminfo
> Active:         813644 kB
> Inactive:       582436 kB

This isn't -rmap.  I would like to help you debug your
problem, but it would be nice if you could at least
record your debugging info running the kernel you want
to have debugged ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

