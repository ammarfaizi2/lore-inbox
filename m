Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162228AbWKPCb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162228AbWKPCb2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162230AbWKPCb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:31:28 -0500
Received: from ra.tuxdriver.com ([70.61.120.52]:34576 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1162224AbWKPCb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:31:27 -0500
Date: Wed, 15 Nov 2006 21:26:29 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Miles Lane <miles.lane@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Bcm43xx-dev@lists.berlios.de,
       Michael Buesch <mb@bu3sch.de>, LKML <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>
Subject: Re: 2.6.19-rc5-mm2 -- bcm43xx busted (backing out the bcm43xx patches fixes it)
Message-ID: <20061116022624.GC3439@tuxdriver.com>
References: <a44ae5cd0611141521pd342109jaae9e27aca3d2200@mail.gmail.com> <200611152116.30734.rjw@sisk.pl> <455BCA05.8000007@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455BCA05.8000007@lwfinger.net>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2006 at 08:16:37PM -0600, Larry Finger wrote:

> NOTE to maintainers: This problem affects BOTH wireless-2.6 and 
> 2.6.19-rcX-mmY. At present, the
> "Move IV/ICV" patch has not been incorporated into 2.6.19-rcX and it is OK.

This patch is available in the 'upstream' branch pull request I posted
yesterday evening:

	http://marc.theaimsgroup.com/?l=linux-netdev&m=116355611923558&w=2

Hth!

John
-- 
John W. Linville
linville@tuxdriver.com
