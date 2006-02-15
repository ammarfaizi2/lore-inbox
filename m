Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422890AbWBOGtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422890AbWBOGtg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 01:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422896AbWBOGtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 01:49:36 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:42006 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1422890AbWBOGtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 01:49:35 -0500
Date: Wed, 15 Feb 2006 08:48:36 +0200
From: Gleb Natapov <gleb@minantech.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au, mst@mellanox.co.il,
       hugh@veritas.com, wli@holomorphy.com, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       vandrove@vc.cvut.cz, pbadari@us.ibm.com, grundler@parisc-linux.org,
       matthew@wil.cx
Subject: Re: [PATCH] Fix up MADV_DONTFORK/MADV_DOFORK definitions
Message-ID: <20060215064836.GG24524@minantech.com>
References: <20060213210906.GC13603@mellanox.co.il> <Pine.LNX.4.61.0602132157110.3761@goblin.wat.veritas.com> <Pine.LNX.4.64.0602131426470.3691@g5.osdl.org> <20060213225538.GE13603@mellanox.co.il> <Pine.LNX.4.61.0602132259450.4627@goblin.wat.veritas.com> <20060213233517.GG13603@mellanox.co.il> <43F2AEAE.5010700@yahoo.com.au> <adawtfxqhk1.fsf@cisco.com> <20060214221654.67288424.akpm@osdl.org> <adaslqlqgdz.fsf_-_@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adaslqlqgdz.fsf_-_@cisco.com>
X-OriginalArrivalTime: 15 Feb 2006 06:49:34.0220 (UTC) FILETIME=[FAE064C0:01C631FB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 10:34:48PM -0800, Roland Dreier wrote:
>     Andrew> yes, please do.
> 
> OK, here's a patch that changes them to 9 and 10.  I would hold off
> sending this to Linus until Michael has a chance to speak up, in case
> there's a reason I don't know for choosing 0x30 and 0x31.
> 
Here
http://marc.theaimsgroup.com/?l=linux-kernel&m=113162971606408&w=2
at the end there is a reasoning. So I think 9 and 10 will do too.
By the way Nick was on CC list back than and haven't raised any 
concerns :)


--
			Gleb.
