Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266116AbUJLQ24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266116AbUJLQ24 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 12:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266127AbUJLQ24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 12:28:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44239 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266116AbUJLQ2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 12:28:53 -0400
Date: Tue, 12 Oct 2004 12:28:48 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@cpushare.com>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: secure computing for 2.6.7
In-Reply-To: <20041012155942.GG17372@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0410121228230.13693-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2004, Andrea Arcangeli wrote:

> http://www.cpushare.com/download/cpushare-0.4.tar.bz2
> 
> check python seccomp_test.py and seccomp-loader.c.

Looks like it should work, though really only for the
purposes of cpushare and nothing else.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

