Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVALLcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVALLcl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 06:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbVALLcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 06:32:35 -0500
Received: from unthought.net ([212.97.129.88]:40075 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S261154AbVALLc0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 06:32:26 -0500
Date: Wed, 12 Jan 2005 12:32:24 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Valdis.Kletnieks@vt.edu, Joel Jaeggli <joelja@darkwing.uoregon.edu>,
       Anton Blanchard <anton@samba.org>, Phy Prabab <phyprabab@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux NFS vs NetApp
Message-ID: <20050112113224.GB347@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	"J. Bruce Fields" <bfields@fieldses.org>, Valdis.Kletnieks@vt.edu,
	Joel Jaeggli <joelja@darkwing.uoregon.edu>,
	Anton Blanchard <anton@samba.org>, Phy Prabab <phyprabab@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20050111025401.48311.qmail@web51810.mail.yahoo.com> <20050111035810.GG14239@krispykreme.ozlabs.ibm.com> <Pine.LNX.4.61.0501102321490.25796@twin.uoregon.edu> <200501110920.j0B9JwAL006980@turing-police.cc.vt.edu> <20050111100109.GA347@unthought.net> <20050111144317.GA23849@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050111144317.GA23849@fieldses.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 09:43:17AM -0500, J. Bruce Fields wrote:
> On Tue, Jan 11, 2005 at 11:01:10AM +0100, Jakob Oestergaard wrote:
> > 3 knfsd will give you stale handles (can be worked around by stat'ing
> >   all your directories constantly on the server side)
> 
> This should be fixed now.  Bug reports to the contrary welcomed.

Excellent!

It seems SGI has merged their XFS kernel up to 2.6.10 - I'll give that a
try and see what happens.


Thanks,

-- 

 / jakob

