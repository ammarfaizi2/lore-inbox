Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbTE2ROo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 13:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbTE2ROn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 13:14:43 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:56016 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262424AbTE2ROm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 13:14:42 -0400
Date: Thu, 29 May 2003 19:27:58 +0200
From: Jens Axboe <axboe@suse.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: andrew <akpm@digeo.com>, linux-kernel@vger.kernel.org, nsharoff@us.ibm.com
Subject: Re: 2.5.70-mm1 panic with as-scheduler ?
Message-ID: <20030529172758.GQ845@suse.de>
References: <200305290846.52019.pbadari@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305290846.52019.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29 2003, Badari Pulavarty wrote:
> Andrew,
> 
> Here is the BUG() we got on 2.5.70-mm1.
> Is this a known problem with AS ?

Yes, -mm2 has the fix.

-- 
Jens Axboe

