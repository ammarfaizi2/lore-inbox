Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264697AbUEJOMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264697AbUEJOMo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 10:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264700AbUEJOMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 10:12:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2782 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264697AbUEJOMn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 10:12:43 -0400
Date: Mon, 10 May 2004 10:12:12 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       Andrew Morton <akpm@osdl.org>, <dipankar@in.ibm.com>,
       <manfred@colorfullife.com>, <davej@redhat.com>, <wli@holomorphy.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <maneesh@in.ibm.com>
Subject: Re: dentry bloat.
In-Reply-To: <Pine.LNX.4.58.0405090832310.24865@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.44.0405101011470.16315-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 May 2004, Linus Torvalds wrote:

> so Andrew really must have a fairly different setup if he sees 20% 
> filenames being > 23 characters.

Just look at the patch names in the -mm tree ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

