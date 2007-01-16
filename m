Return-Path: <linux-kernel-owner+w=401wt.eu-S1750936AbXAPSym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbXAPSym (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 13:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbXAPSyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 13:54:38 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:45458 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900AbXAPSyg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 13:54:36 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=FLwNBYXkciwKDauRLXcZVXekPs8gwJpnCqBwwgsJbHJIL4EkWCAtXETUfnTyHppVGmCeEuGxnPIpCnFs+1AeOf1ugUXbmfn+PPltFjVS4WRI2bXfp+zUza0wAAiT+LvUc06cZV7v6iXA9GW+3QqnLEiMOXnAIL3VQayn7x8uMXA=
Date: Tue, 16 Jan 2007 20:54:14 +0200
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: isely@pobox.com, video4linux-list@redhat.com, linux-kernel@vger.kernel.org,
       trivial@kernel.org
Subject: Re: [PATCH 2.6.20-rc5 2/4] pvrusb2: Use ARRAY_SIZE macro
Message-ID: <20070116185414.GC718@Ahmed>
References: <20070116080136.GA30133@Ahmed> <Pine.LNX.4.64.0701160334350.20244@CPE00045a9c397f-CM001225dbafb6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701160334350.20244@CPE00045a9c397f-CM001225dbafb6>
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2007 at 03:36:16AM -0500, Robert P. J. Day wrote:
> On Tue, 16 Jan 2007, Ahmed S. Darwish wrote:
> 
> > Use ARRAY_SIZE macro in pvrusb2-hdw.c file
> >
> > Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
> 
> ... snip ...
> 
> i'm not sure it's worth submitting multiple patches to convert code
> expressions to the ARRAY_SIZE() macro since i was going to wait for
> the next kernel release, and do that in one fell swoop with a single
> patch.

No problem :). But will a single patch be accepted ?. Grepping the tree,I found
many results that will make the patch very very big. 
Should I stop sending them till 2.6.20 ?. 
If so, I've made any way about 10 patches dealing with different subsytems. 
I can send them to you to avoid this little work duplication.


Regards
-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
