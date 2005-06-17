Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261977AbVFQOA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbVFQOA1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 10:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbVFQOA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 10:00:27 -0400
Received: from ozlabs.org ([203.10.76.45]:13993 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261977AbVFQOAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 10:00:25 -0400
Date: Fri, 17 Jun 2005 23:55:36 +1000
From: Anton Blanchard <anton@samba.org>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, christoph <christoph@scalex86.org>,
       linux-kernel@vger.kernel.org, shai@scalex86.org
Subject: Re: [PATCH] Move some variables into the "most_readonly" section??
Message-ID: <20050617135536.GB6434@krispykreme>
References: <Pine.LNX.4.62.0506071253020.2850@ScMPusgw> <20050608131839.GP23831@wotan.suse.de> <Pine.LNX.4.62.0506141551350.3676@ScMPusgw> <20050614162354.6aabe57e.akpm@osdl.org> <Pine.LNX.4.62.0506141644160.4099@ScMPusgw> <20050614165818.6f83fa6c.akpm@osdl.org> <Pine.LNX.4.62.0506141704150.4225@ScMPusgw> <20050614171602.12bfa245.akpm@osdl.org> <20050615004153.GX11898@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050615004153.GX11898@wotan.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I think it would be better to first still see numbers for
> this questionable optimizations.

Agreed, it would be nice to see some benchmark numbers.

Anton
