Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264142AbTDXUV0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 16:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264174AbTDXUV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 16:21:26 -0400
Received: from to-telus.redhat.com ([207.219.125.105]:54770 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id S264142AbTDXUVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 16:21:25 -0400
Date: Thu, 24 Apr 2003 16:33:34 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Andrew Morton <akpm@digeo.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.68-mm2
Message-ID: <20030424163334.A12180@redhat.com>
References: <20030423233652.C9036@redhat.com> <Pine.LNX.3.96.1030424162101.11351C-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.96.1030424162101.11351C-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Thu, Apr 24, 2003 at 04:24:56PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 04:24:56PM -0400, Bill Davidsen wrote:
> Of course reasonable way may mean that bash does some things a bit slower,
> but given that the whole thing works well in most cases anyway, I think
> the kernel handling the situation is preferable.

Eh?  It makes bash _faster_ for all cases of starting up a child process.  
And it even works on 2.4 kernels.

		-ben
-- 
Junk email?  <a href="mailto:aart@kvack.org">aart@kvack.org</a>
