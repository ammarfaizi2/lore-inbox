Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVDZBtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVDZBtt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 21:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVDZBts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 21:49:48 -0400
Received: from smtp.istop.com ([66.11.167.126]:47536 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S261204AbVDZBtl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 21:49:41 -0400
From: Daniel Phillips <phillips@istop.com>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: Mercurial 0.3 vs git benchmarks
Date: Mon, 25 Apr 2005 21:49:50 -0400
User-Agent: KMail/1.7
Cc: linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
References: <20050426004111.GI21897@waste.org>
In-Reply-To: <20050426004111.GI21897@waste.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504252149.50735.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 April 2005 20:41, Matt Mackall wrote:
> Despite the above, it compares pretty well to git in speed and is
> quite a bit better in terms of storage space. By reducing the zlib
> compression level, it could probably win across the board.

Hi Matt,

Congratulations on an impressive demo!  How about actually checking the 
compression vs wall clock theory?  And I probably don't have to mention 
psyco...

Regards,

Daniel
