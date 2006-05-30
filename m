Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWE3BdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWE3BdO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 21:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWE3BdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 21:33:10 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:48301 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932127AbWE3BdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 21:33:04 -0400
Date: Tue, 30 May 2006 11:32:33 +1000
From: Nathan Scott <nathans@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: [patch 11/61] lock validator: lockdep: small xfs init_rwsem() cleanup
Message-ID: <20060530113233.A447832@wobbly.melbourne.sgi.com>
References: <20060529212109.GA2058@elte.hu> <20060529212359.GK3155@elte.hu> <20060529183341.58d75aec.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060529183341.58d75aec.akpm@osdl.org>; from akpm@osdl.org on Mon, May 29, 2006 at 06:33:41PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2006 at 06:33:41PM -0700, Andrew Morton wrote:
> I'll queue this for mainline, via the XFS tree.

Thanks Andrew, its merged in our tree now.

-- 
Nathan
