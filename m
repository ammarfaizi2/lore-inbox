Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759170AbWK3Ip6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759170AbWK3Ip6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 03:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759171AbWK3Ip5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 03:45:57 -0500
Received: from il.qumranet.com ([62.219.232.206]:30411 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1759168AbWK3Ip4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 03:45:56 -0500
Message-ID: <456E9A43.3070804@qumranet.com>
Date: Thu, 30 Nov 2006 10:45:55 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Randy Dunlap <randy.dunlap@oracle.com>
CC: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       yaniv@qumranet.com
Subject: Re: [PATCH] KVM: fix NULL and C99 init sparse warnings
References: <20061129131857.bd3c68f9.randy.dunlap@oracle.com>
In-Reply-To: <20061129131857.bd3c68f9.randy.dunlap@oracle.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
>
> Fix sparse NULL and C99 struct init warnings in kvm:
>   

Please copy kvm-devel@lists.sourceforge.net on kvm patches.


Acked-by: Avi Kivity <avi@qumranet.com>


-- 
error compiling committee.c: too many arguments to function

