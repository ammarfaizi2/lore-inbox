Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268714AbUHUAPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268714AbUHUAPR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 20:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268745AbUHUAPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 20:15:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20635 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268714AbUHUAPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 20:15:13 -0400
Date: Fri, 20 Aug 2004 20:15:08 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, <reiserfs-dev@namesys.com>
Subject: Re: 2.6.8.1-mm2 - reiser4
In-Reply-To: <Pine.LNX.4.44.0408201852140.4192-100000@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.44.0408202014270.5028-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2004, Rik van Riel wrote:

> Oh, and another one.

Just spotted another nitpick.

Documentation should probably live in Documentation/fs/reiser4/
instead of fs/reiser4/doc/.   It should be easy to get that fixed.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

