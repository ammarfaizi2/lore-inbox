Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268580AbUHLOwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268580AbUHLOwn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 10:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268583AbUHLOwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 10:52:43 -0400
Received: from jade.spiritone.com ([216.99.193.136]:18857 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S268580AbUHLOwl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 10:52:41 -0400
Date: Thu, 12 Aug 2004 07:50:42 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Paul Jackson <pj@sgi.com>, Shailabh Nagar <nagar@watson.ibm.com>
cc: efocht@hpce.nec.com, lse-tech@lists.sourceforge.net, akpm@osdl.org,
       hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-ID: <8990000.1092322241@[10.10.2.4]>
In-Reply-To: <20040812001522.07d30598.pj@sgi.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com><200408071722.36705.efocht@hpce.nec.com><2447730000.1091976606@[10.10.2.4]><200408111140.14466.efocht@hpce.nec.com><10920000.1092235770@[10.10.2.4]><20040811105057.76f97ead.pj@sgi.com><411A8BAD.1010008@watson.ibm.com> <20040812001522.07d30598.pj@sgi.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> If not (and others agree), lets end this discussion and move on - both 
>> projects have enough to do ...
> 
> At least Martin does not yet agree, if I understand his posts.  But,
> yes, either way, we are close to where it is best to table this
> discussion, for the moment at least.

I'm not in violent disagreement, no ... I just want people to carefully
thrash through the rationale behind what we're doing before we do it ;-)
If the cpusets and CKRM people agree, I'm happy ... just don't want to
end up with multiple interfaces if it's not needed. If it is, then so
be it.

M.

