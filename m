Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262580AbUEAXWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbUEAXWT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 19:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUEAXWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 19:22:19 -0400
Received: from mx2.redhat.com ([66.187.237.31]:65165 "EHLO mx2.redhat.com")
	by vger.kernel.org with ESMTP id S262580AbUEAXWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 19:22:18 -0400
Date: Sat, 1 May 2004 19:22:15 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Buddy Lumpkin <b.lumpkin@comcast.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Large page support in the Linux Kernel?
In-Reply-To: <S262103AbUEAJXe/20040501092334Z+498@vger.kernel.org>
Message-ID: <Pine.LNX.4.44.0405011921180.14181-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 May 2004, Buddy Lumpkin wrote:

> I was wondering if there is going to be large page support for the linux
> kernel in the near future.

I'm sorry to disappoint you, but your request is a few years
too late.  RHEL2.1, RHEL3, UL and the 2.6 kernel have had
large page support for SHM segments for quite a while now.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

