Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262685AbVG2R6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262685AbVG2R6E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 13:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbVG2R6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 13:58:04 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:51948 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S262685AbVG2R5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 13:57:18 -0400
Date: Fri, 29 Jul 2005 19:57:14 +0200
From: David Weinehall <tao@acc.umu.se>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-kernel@vger.kernel.org
Subject: Re: kernel guide to space (updated)
Message-ID: <20050729175714.GE9841@khan.acc.umu.se>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	"Michael S. Tsirkin" <mst@mellanox.co.il>,
	linux-kernel@vger.kernel.org
References: <20050728145353.GL11644@mellanox.co.il> <Pine.LNX.4.61.0507290929250.26861@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507290929250.26861@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pub_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2005 at 09:40:14AM +0200, Jan Engelhardt wrote:
[snip]
> Would it be reasonable to say that the first column can be a space?
> Some editors (e.g. joe) list the function in some status bar and do
> that based on the fact that all C code in a function is indented, and
> only the function header is non-indented. Putting a label statement
> fools the algorithm.  joe-bug or option for freedom?

I'd definitely call that a joe-bug.  Adding extra space for no good
reason is just silly; for consistency we'd have to add a space for the
case <foo>: labels also...


Regards: David
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
