Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266659AbUFWUhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266659AbUFWUhv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 16:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266661AbUFWUhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 16:37:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25992 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266659AbUFWUhQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 16:37:16 -0400
Date: Wed, 23 Jun 2004 16:37:04 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Amit Gud <gud@eth.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Elastic Quota File System (EQFS)
In-Reply-To: <40d9ac40.674.0@eth.net>
Message-ID: <Pine.LNX.4.44.0406231636240.12204-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2004, Amit Gud wrote:

> That is the user's quota which he doesn't need is given to the users who
> need it, but on 100% assurance that the originl user can any time
> reclaim his/her quota.

Where do you put to store the "extra data" of the over-quota
users if it can't be stored on the filesystem ?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

