Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVFFHrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVFFHrr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 03:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVFFHrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 03:47:47 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:59785 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261194AbVFFHro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 03:47:44 -0400
Date: Mon, 6 Jun 2005 09:47:45 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: Easy trick to reduce kernel footprint
Message-ID: <20050606074745.GC24826@wohnheim.fh-wedel.de>
References: <20050605223528.GA13726@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050605223528.GA13726@alpha.home.local>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 June 2005 00:35:28 +0200, Willy Tarreau wrote:
> 
> I recently discovered p7zip which comes with the LZMA compression algorithm,
> which is somewhat better than gzip and bzip2 on most datasets, [...]

Hmmm.

Citeseer has never heard of that algorithm, top 10 google hits for
"LZMA compression algorithm" are completely uninformative.  Does
anyone actually know, what this algorithm is doing?

Jörn

-- 
Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it.
-- Brian W. Kernighan
