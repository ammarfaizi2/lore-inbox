Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268442AbUHLAcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268442AbUHLAcn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 20:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268416AbUHLAaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 20:30:10 -0400
Received: from mx13.sac.fedex.com ([199.81.197.53]:10002 "EHLO
	mx13.sac.fedex.com") by vger.kernel.org with ESMTP id S268367AbUHKX6w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 19:58:52 -0400
Date: Thu, 12 Aug 2004 07:55:52 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Tomas Szepe <szepe@pinerecords.com>
cc: Stephen Hemminger <shemminger@osdl.org>,
       James Ketrenos <jketreno@linux.intel.com>,
       Christoph Hellwig <hch@infradead.org>, Pavel Machek <pavel@suse.cz>,
       Jeff Chua <jeffchua@silk.corp.fedex.com>, netdev@oss.sgi.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ipw2100 wireless driver
In-Reply-To: <20040811163333.GE10100@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.61.0408120754410.1632@boston.corp.fedex.com>
References: <Pine.LNX.4.60.0407141947270.27995@boston.corp.fedex.com>
 <20040714115523.GC2269@elf.ucw.cz> <20040809201556.GB9677@louise.pinerecords.com>
 <Pine.LNX.4.61.0408101258130.1290@boston.corp.fedex.com>
 <20040810075558.A14154@infradead.org> <20040810101640.GF9034@atrey.karlin.mff.cuni.cz>
 <4119F203.1070009@linux.intel.com> <20040811114437.A27439@infradead.org>
 <411A478E.1080101@linux.intel.com> <20040811093043.522cc5a0@dell_ss3.pdx.osdl.net>
 <20040811163333.GE10100@louise.pinerecords.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 08/12/2004
 07:58:38 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 08/12/2004
 07:58:41 AM,
	Serialize complete at 08/12/2004 07:58:41 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2004, Tomas Szepe wrote:

> Or better yet, let's not!
>
> There are many people who don't want to mess around with hotplug just
> to get a single driver to load.

Agreed. Please leave the legacy-loader in there. I don't need hotplug 
scripts just to load a single firmware on my X31.

Thanks,
Jeff

