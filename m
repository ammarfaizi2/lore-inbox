Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262364AbVBKWNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbVBKWNq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 17:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbVBKWNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 17:13:46 -0500
Received: from lyle.provo.novell.com ([137.65.81.174]:62046 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S262364AbVBKWNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 17:13:45 -0500
Date: Fri, 11 Feb 2005 14:13:23 -0800
From: Greg KH <gregkh@suse.de>
To: andersen@codepoet.org, Christian Borntr?ger <christian@borntraeger.net>,
       Bill Nottingham <notting@redhat.com>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
Message-ID: <20050211221323.GC23606@suse.de>
References: <20050211004033.GA26624@suse.de> <20050211031823.GE29375@nostromo.devel.redhat.com> <1108104417.32129.7.camel@localhost.localdomain> <200502111719.23163.christian@borntraeger.net> <20050211170144.GA16074@suse.de> <20050211190153.GA8110@codepoet.org> <20050211192323.GA19787@suse.de> <20050211223731.A1635@banaan.localdomain> <20050211214957.GA22633@suse.de> <20050211230657.B1635@banaan.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050211230657.B1635@banaan.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2005 at 11:06:57PM +0100, Erik van Konijnenburg wrote:
> For an old version of the idea, see
> 
> 	http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=284294

Very nice stuff.  Ok, that's a good reason not to get rid of these
files, although they can be generated on the fly from the modules
themselves (like depmod does it.)

thanks,

greg k-h
