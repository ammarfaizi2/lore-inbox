Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264992AbTBEWEm>; Wed, 5 Feb 2003 17:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265065AbTBEWEm>; Wed, 5 Feb 2003 17:04:42 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:62479 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264992AbTBEWEl>;
	Wed, 5 Feb 2003 17:04:41 -0500
Date: Wed, 5 Feb 2003 14:09:56 -0800
From: Greg KH <greg@kroah.com>
To: Scott Murray <scottm@somanetworks.com>
Cc: Rusty Lynch <rusty@linux.co.intel.com>, Patrick Mochel <mochel@osdl.org>,
       Stanley Wang <stanley.wang@linux.co.intel.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5.59-bk]Sysfs interface for ZT5550 Redundant Host Controller
Message-ID: <20030205220956.GB21652@kroah.com>
References: <1044478128.2270.17.camel@vmhack> <Pine.LNX.4.44.0302051606530.29820-100000@rancor.yyz.somanetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302051606530.29820-100000@rancor.yyz.somanetworks.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2003 at 04:14:10PM -0500, Scott Murray wrote:
> On 5 Feb 2003, Rusty Lynch wrote:
> 
> > Here is a second version of the zt5550 reduncant host controller sysfs
> > interface patch.  I have first of all removed several of the more advanced
> > (and therefore more dangerous) chip features, and also moved the root
> > of these files to the 'zt5550_hc' directory that was already being created
> > in bus/pci/drivers/ so that the directory view now looks like:
> 
> I'll likely poke around a bit more, but I can probably live with something 
> along these lines.

Does that mean you want me to add this patch to the kernel tree?

thanks,

greg k-h
