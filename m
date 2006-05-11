Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbWEKIs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbWEKIs0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 04:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965212AbWEKIs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 04:48:26 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:45696 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S965211AbWEKIsZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 04:48:25 -0400
Date: Thu, 11 May 2006 01:51:27 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Gerd Hoffmann <kraxel@suse.de>
Cc: Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@sous-sol.org>,
       virtualization@lists.osdl.org,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [Xen-devel] Re: [RFC PATCH 07/35] Make LOAD_OFFSET defined by subarch
Message-ID: <20060511085127.GH25010@moss.sous-sol.org>
References: <20060509084945.373541000@sous-sol.org> <20060509085150.509458000@sous-sol.org> <44627733.4010305@vmware.com> <4462EC05.8060705@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4462EC05.8060705@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Gerd Hoffmann (kraxel@suse.de) wrote:
> I fully agree.  Attached below is a patch (against xen unstable
> mercurial tree) which does exactly that ;)

Thanks Gerd, I thought you had been working on that.  Was the concern
with vaddr vs. paddr worked out?

thanks,
-chris
