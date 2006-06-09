Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932582AbWFIXPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbWFIXPj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 19:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbWFIXPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 19:15:39 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:169 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932582AbWFIXPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 19:15:38 -0400
Message-ID: <448A010F.9060701@garzik.org>
Date: Fri, 09 Jun 2006 19:15:27 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Sonny Rao <sonny@burdell.org>,
       jeff@garzik.org, hch@infradead.org, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <20060609091327.GA3679@infradead.org> <20060609030759.48cd17a0.akpm@osdl.org> <44899653.1020007@garzik.org> <20060609095620.22326f9d.akpm@osdl.org> <4489AAD9.80806@garzik.org> <20060609103543.52c00c62.akpm@osdl.org> <20060609214200.GA18213@kevlar.burdell.org> <20060609151553.30097b44.akpm@osdl.org> <20060609231151.GL5964@schatzie.adilger.int>
In-Reply-To: <20060609231151.GL5964@schatzie.adilger.int>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> I'm not so strongly against ext4 that I won't follow that route if needed,
> but it essentially means that ext3 will be orphaned.

Not orphaned but scaled back over time.  IMO there's only so much 
developer and brain and test bandwidth for "the main Linux filesystem."

	Jeff


