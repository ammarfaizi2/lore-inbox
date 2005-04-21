Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbVDUUQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVDUUQA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 16:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbVDUUP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 16:15:59 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:34451 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S261851AbVDUUPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 16:15:54 -0400
Message-ID: <426809C3.7010101@ammasso.com>
Date: Thu, 21 Apr 2005 15:14:59 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Andy Isaacson <adi@hexapodia.org>, Troy Benjegerdes <hozer@hozed.org>,
       Bernhard Fischer <blist@aon.at>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs
 implementation
References: <20050421173821.GA13312@hexapodia.org> <4267F367.3090508@ammasso.com> <20050421195641.GB13312@hexapodia.org> <4268080E.3000303@ammasso.com> <20050421201227.GI23013@shell0.pdx.osdl.net>
In-Reply-To: <20050421201227.GI23013@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:

> FYI, that will not work on all 2.6 kernels.  Specifically anything that's
> not using capabilities.

It works with every kernel I've tried.  I'm sure there are plenty of kernel configuration 
options that will break our driver.  But as long as all the distros our customers use 
work, as well as reasonably-configured custom kernels, we're happy.

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13
