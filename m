Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262527AbTEAASt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 20:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbTEAASs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 20:18:48 -0400
Received: from pointblue.com.pl ([62.89.73.6]:58125 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S262527AbTEAASs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 20:18:48 -0400
Subject: Re: 2.5.68-bk10 blkmtd.c:219: warning: implicit declaration of
	function `alloc_kiovec'
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: Andrew Morton <akpm@digeo.com>
Cc: greg@kroah.com, rddunlap@osdl.org, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030430171047.2f22ed70.akpm@digeo.com>
References: <1051745126.5274.22.camel@flat41>
	 <1051747119.5315.28.camel@flat41>  <20030430171047.2f22ed70.akpm@digeo.com>
Content-Type: text/plain
Organization: K4 labs
Message-Id: <1051749144.5630.2.camel@flat41>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 01 May 2003 01:32:24 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-01 at 01:10, Andrew Morton wrote:

> 
> blkmtd died when kiobufs were removed.  The maintainer said "oh well, OK, I
> need to rewrite it anyway" but that obviously has not yet happened.

:/ 

So why we still have this in kernel ?
I don't have any of those devices, so i am not even able to correct
this. If i will have, i will do so (at least try).

I hope that is the only case, when somebody leaves project this way.

-- 
Grzegorz Jaskiewicz <gj@pointblue.com.pl>
K4 labs

