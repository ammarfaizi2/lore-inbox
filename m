Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbVIWVUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbVIWVUO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 17:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbVIWVUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 17:20:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7143 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751301AbVIWVUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 17:20:12 -0400
Date: Fri, 23 Sep 2005 22:19:53 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: LKML <linux-kernel@vger.kernel.org>,
       user-mode-linux-devel@lists.sourceforge.net,
       user-mode-linux-user@lists.sourceforge.net
Subject: Re: Writing on DM snapshots, and having no "mainstream" device (was: Re: Fw: [PATCH 1/7] Add dm-snapshot tutorial in Documentation)
Message-ID: <20050923211953.GG18976@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Blaisorblade <blaisorblade@yahoo.it>,
	LKML <linux-kernel@vger.kernel.org>,
	user-mode-linux-devel@lists.sourceforge.net,
	user-mode-linux-user@lists.sourceforge.net
References: <20050920163433.6081be3b.akpm@osdl.org> <20050921154846.GW18976@agk.surrey.redhat.com> <200509232211.32238.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509232211.32238.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 10:11:31PM +0200, Blaisorblade wrote:
> you can create snapshots *WITHOUT* having a snapshot-origin device 
 
Checking the code, yes you're correct.
When that LVM2 code was developed you'd get an oops but it's been fixed.

Alasdair
-- 
agk@redhat.com
