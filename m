Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267182AbUHDBXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267182AbUHDBXG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 21:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbUHDBXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 21:23:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29095 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267182AbUHDBW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 21:22:58 -0400
Date: Tue, 3 Aug 2004 21:22:45 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: Gerrit Huizenga <gh@us.ibm.com>
cc: Andrea Arcangeli <andrea@suse.de>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>, <linux-kernel@vger.kernel.org>,
       <akpm@osdl.org>
Subject: Re: [patch] mlock-as-nonroot revisted 
In-Reply-To: <E1Bs7bj-0006pz-00@w-gerrit2>
Message-ID: <Pine.LNX.4.44.0408032122210.5948-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Aug 2004, Gerrit Huizenga wrote:

> DB2, JVM also use hugetlbfs, other uses have been tried with
> some success.

OK.  Do any of those do the "root chowns an unnamed
hugetlbfs file" scenario ? ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

