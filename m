Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266831AbUHXP7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266831AbUHXP7K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 11:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268047AbUHXP7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 11:59:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8384 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266831AbUHXP7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 11:59:03 -0400
Date: Tue, 24 Aug 2004 11:57:45 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Tim Schmielau <tim@physik3.uni-rostock.de>
cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] make oom killer points unsigned long
In-Reply-To: <Pine.LNX.4.53.0408241745020.6266@gockel.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.44.0408241156590.3884-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2004, Tim Schmielau wrote:

> Signed-off-by: Tim Schmielau <tim@physik3.uni-rostock.de>

Patch looks safe and obvious to me.  Andrew, could you please
apply it for the next -mm ?


-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

