Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVDZPT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVDZPT2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 11:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbVDZPTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 11:19:25 -0400
Received: from mail.shareable.org ([81.29.64.88]:10921 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261568AbVDZPTW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 11:19:22 -0400
Date: Tue, 26 Apr 2005 16:19:16 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Artem B. Bityuckiy" <dedekind@oktetlabs.ru>
Cc: Ville Herva <v@iki.fi>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: filesystem transactions API
Message-ID: <20050426151916.GA14297@mail.shareable.org>
References: <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk> <OF32F95BBA.F38B2D1F-ON88256FEE.006FE841-88256FEE.00742E46@us.ibm.com> <20050426134629.GU16169@viasys.com> <20050426141426.GC10833@mail.shareable.org> <426E4EBD.6070104@oktetlabs.ru> <20050426143247.GF10833@mail.shareable.org> <426E5428.2090306@oktetlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426E5428.2090306@oktetlabs.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Artem B. Bityuckiy wrote:
> Hmm, so the whole point to implement transactions in the kernel space is 
> to do the transactions in a way that nobody can see any intermediate 
> inconsistent state ?

Yes.

-- Jamie
