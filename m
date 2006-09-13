Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWIMRve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWIMRve (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 13:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbWIMRve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 13:51:34 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:45507 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750839AbWIMRvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 13:51:33 -0400
Message-ID: <45084524.9090609@vmware.com>
Date: Wed, 13 Sep 2006 10:51:32 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, akpm@osdl.org,
       nickpiggin@yahoo.com.au, frankeh@watson.ibm.com, rhim@cc.gateh.edu
Subject: Re: [patch 0/9] Guest page hinting: cover sheet.
References: <20060901110836.GA15684@skybase>
In-Reply-To: <20060901110836.GA15684@skybase>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky wrote:
> Only difference of this patch-set compare to the one posted on linux-mm
> is that this patch-set is against 2.6.18-rc5-mm1. To go back to Andrews
> question: is this useful for anybody else in addition to s390

Yes, it is useful for VMware as well.  I am looking through the patches 
now, and it looks as if they are useful without any changes needed.

Zach
