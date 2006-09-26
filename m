Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWIZFFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWIZFFA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWIZFE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:04:59 -0400
Received: from mga03.intel.com ([143.182.124.21]:26720 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1750949AbWIZFE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:04:59 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,217,1157353200"; 
   d="scan'208"; a="122908552:sNHT854837893"
Message-ID: <4518B451.4080303@intel.com>
Date: Mon, 25 Sep 2006 22:02:09 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore __iomem annotations in e1000
References: <20060923003240.GF29920@ftp.linux.org.uk> <45186F87.8080207@pobox.com>
In-Reply-To: <45186F87.8080207@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> applied
> 

Thanks,

I have no idea why and when these annotations were lost, but we have them in 
much older versions of the code. I'll try to track it down and make sure that 
it doesn't disappear again.

Cheers,

Auke
