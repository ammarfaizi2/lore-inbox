Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262794AbVAKOnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbVAKOnY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 09:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262793AbVAKOnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 09:43:23 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:31181 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S262791AbVAKOnU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 09:43:20 -0500
Date: Tue, 11 Jan 2005 09:43:17 -0500
To: Jakob Oestergaard <jakob@unthought.net>, Valdis.Kletnieks@vt.edu,
       Joel Jaeggli <joelja@darkwing.uoregon.edu>,
       Anton Blanchard <anton@samba.org>, Phy Prabab <phyprabab@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux NFS vs NetApp
Message-ID: <20050111144317.GA23849@fieldses.org>
References: <20050111025401.48311.qmail@web51810.mail.yahoo.com> <20050111035810.GG14239@krispykreme.ozlabs.ibm.com> <Pine.LNX.4.61.0501102321490.25796@twin.uoregon.edu> <200501110920.j0B9JwAL006980@turing-police.cc.vt.edu> <20050111100109.GA347@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050111100109.GA347@unthought.net>
User-Agent: Mutt/1.5.6+20040907i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 11:01:10AM +0100, Jakob Oestergaard wrote:
> 3 knfsd will give you stale handles (can be worked around by stat'ing
>   all your directories constantly on the server side)

This should be fixed now.  Bug reports to the contrary welcomed.
--Bruce Fields
