Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266303AbUGKA6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266303AbUGKA6B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 20:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266466AbUGKA6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 20:58:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8370 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266303AbUGKA56 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 20:57:58 -0400
Date: Sat, 10 Jul 2004 20:57:56 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: John Richard Moser <nigelenki@comcast.net>
cc: linux-kernel@vger.kernel.org,
       linux-c-programming <linux-c-programming@vger.kernel.org>
Subject: Re: Garbage Collection and Swap
In-Reply-To: <40EF3BCD.7080808@comcast.net>
Message-ID: <Pine.LNX.4.44.0407102057230.14732-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jul 2004, John Richard Moser wrote:

> I've been researching garbage collection.

Look up "generational garbage collection".

I suspect that, when tuned right, generational garbage
collection could actually be quite VM friendly...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

