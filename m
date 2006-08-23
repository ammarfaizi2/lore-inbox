Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965307AbWHWXZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965307AbWHWXZy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 19:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965308AbWHWXZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 19:25:54 -0400
Received: from mail.gurulabs.com ([67.137.148.7]:37286 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S965307AbWHWXZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 19:25:53 -0400
Subject: Re: Areca arcmsr kernel integration for 2.6.18?
From: Dax Kelson <dax@gurulabs.com>
To: James Bottomley <James.Bottomley@SteelEye.com>, Greg KH <gregkh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Theodore Bullock <tbullock@nortel.com>,
       robm@fastmail.fm, brong@fastmail.fm, erich@areca.com.tw, greg@kroah.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <1154530428.3683.0.camel@mulgrave.il.steeleye.com>
References: <00a701c6b2b4$bb564b50$0e00cb0a@robm>
	 <25E284CCA9C9A14B89515B116139A94D0C78805F@zrtphxm0.corp.nortel.com>
	 <20060731200309.bd55c545.akpm@osdl.org>
	 <1154530428.3683.0.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 17:25:51 -0600
Message-Id: <1156375551.4306.10.camel@mentorng.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-02 at 10:53 -0400, James Bottomley wrote:
> On Mon, 2006-07-31 at 20:03 -0700, Andrew Morton wrote:
> > > Ok, so how does this go from here into the mainline kernel?
> > 
> > James has moved the driver into the scsi-misc tree, so I assume he has
> > 2.6.19 plans for it.
> 
> Yes, that's the usual path for scsi-misc.
> 
> James

It would be great if the arcmsr driver could be included in 2.6.18 so it
can make into all the new distro releases that will be happening the
last 3-4 months of the year.

It is completely self contained and it isn't changing any existing code
(ergo it can't break anything) so I believe there is quite a bit of
precedence for "late" inclusion in 2.6.18?

There are lots of users of this hardware (myself included) that would be
very appreciative.

Dax Kelson

