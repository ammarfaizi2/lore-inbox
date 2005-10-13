Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751580AbVJMTSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbVJMTSO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 15:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbVJMTSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 15:18:14 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:65210 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751580AbVJMTSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 15:18:12 -0400
Message-ID: <434EB2E9.5090004@engr.sgi.com>
Date: Thu, 13 Oct 2005 12:18:01 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Frank van Maarseveen <frankvm@frankvm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/21] mm: update_hiwaters just in time
References: <Pine.LNX.4.61.0510130143240.4060@goblin.wat.veritas.com> <Pine.LNX.4.61.0510130148350.4060@goblin.wat.veritas.com> <Pine.LNX.4.62.0510121807090.11311@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0510121807090.11311@schroedinger.engr.sgi.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> Looks fine to me. Great innovative idea on how to reduce the resources 
> needed for the counters.
> 
> Jay, what do you say?

Yes, looks good to me.
My testing results were good also. :)

Thanks, Hugh!
  - jay

