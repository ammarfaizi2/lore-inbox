Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267186AbUJLSFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267186AbUJLSFH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 14:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266538AbUJLSFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 14:05:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20130 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267186AbUJLSEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 14:04:43 -0400
Date: Tue, 12 Oct 2004 14:04:28 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@cpushare.com>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: secure computing for 2.6.7
In-Reply-To: <20041012174605.GH17372@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0410121403000.13693-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2004, Andrea Arcangeli wrote:
> On Tue, Oct 12, 2004 at 12:28:48PM -0400, Rik van Riel wrote:
> > Looks like it should work, though really only for the
> > purposes of cpushare and nothing else.

> However as said boinc and seti would better start using it too.

Are they interested ?

> And people could start using it for other things too every time they
> deal with untrusted data or bytecode.

Would be interesting for eg. browser plugins, though I don't
know whether the current seccomp infrastructure is powerful
enough for that ...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

