Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVFMGl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVFMGl5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 02:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVFMGl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 02:41:56 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:47081 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S261382AbVFMGlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 02:41:55 -0400
Date: Mon, 13 Jun 2005 08:41:52 +0200
From: David Weinehall <tao@acc.umu.se>
To: Ron Peterson <rpeterso@mtholyoke.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: slow directory listing
Message-ID: <20050613064152.GJ20439@khan.acc.umu.se>
Mail-Followup-To: Ron Peterson <rpeterso@mtholyoke.edu>,
	linux-kernel@vger.kernel.org
References: <20050610143720.GA14454@mtholyoke.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050610143720.GA14454@mtholyoke.edu>
User-Agent: Mutt/1.4.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pub_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 10:37:20AM -0400, Ron Peterson wrote:
[snip]
> The times taken to do a directory listing are significantly different.
> 
> 1037# time ls /test/a2 > /dev/null

[snip]

Do you get the same results if you use ls with the -U (unsorted) flag?


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
