Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263227AbUE1Okn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263227AbUE1Okn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 10:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263079AbUE1Okn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 10:40:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48537 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263227AbUE1OkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 10:40:22 -0400
Date: Fri, 28 May 2004 10:39:57 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andi Kleen <ak@muc.de>
cc: Andrey Panin <pazke@donpac.ru>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/13] 2.6.7-rc1-mm1, Simplify DMI matching data
In-Reply-To: <m3zn7su4lv.fsf@averell.firstfloor.org>
Message-ID: <Pine.LNX.4.44.0405281039230.13499-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 May 2004, Andi Kleen wrote:

> There are large third party patchkits for DMI

I think you just identified the problem...

> and "cleaning up"  the format will just cause lots of rejects and pain.

And this isn't it. ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

