Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbTJJO4A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 10:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbTJJOz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 10:55:59 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:60201 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262859AbTJJOz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 10:55:58 -0400
Date: Fri, 10 Oct 2003 10:55:54 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Nico Schottelius <nico-kernel@schottelius.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Memory Issues (2.6 and later)
In-Reply-To: <20031009181617.GB7591@schottelius.org>
Message-ID: <Pine.LNX.4.44.0310101055190.18387-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Oct 2003, Nico Schottelius wrote:

> Any ideas where the problem is?

No. It would help if you showed us some output from 'vmstat 5'
near when the system runs out of memory, and maybe an overview
of how much memory you have and how much is taken by programs.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

