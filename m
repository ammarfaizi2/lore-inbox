Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269354AbTGUHmK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 03:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269358AbTGUHmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 03:42:10 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:7630 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S269354AbTGUHmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 03:42:07 -0400
Date: Mon, 21 Jul 2003 17:58:15 +1000
From: CaT <cat@zip.com.au>
To: Greg KH <greg@kroah.com>
Cc: sensors@stimpy.netroedge.com, frodol@dds.nl, linux-kernel@vger.kernel.org,
       phil@netroedge.com
Subject: Re: 2.6.0-t1: i2c+sensors still whacky
Message-ID: <20030721075815.GC640@zip.com.au>
References: <20030715161127.GA2925@kroah.com> <20030716060443.GA784@zip.com.au> <20030716061009.GA5037@kroah.com> <20030716062922.GA1000@zip.com.au> <20030716073135.GA5338@kroah.com> <20030716224718.GA4612@zip.com.au> <20030716225452.GA3419@kroah.com> <20030717153348.GO4612@zip.com.au> <20030718023350.GA5902@kroah.com> <20030721073753.GA640@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030721073753.GA640@zip.com.au>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 21, 2003 at 05:37:54PM +1000, CaT wrote:
> On Thu, Jul 17, 2003 at 07:33:51PM -0700, Greg KH wrote:
> > On Fri, Jul 18, 2003 at 01:33:48AM +1000, CaT wrote:
> > > > sensors package for 2.4 uses?  And 2.4 works just fine, right?
> > > 
> > > I don't use 2.4. Haven't for ages.
> > 
> > I would _really_ encourage you to try this, and run the sensors_detect
> 
> Good thing you did. :)

Gah. Too tired. I used the following:

linux kernel 2.4.22-pre7
lm sensors 2.8.0
i2c 2.8.0

Did not use inbuilt i2c.

-- 
"How can I not love the Americans? They helped me with a flat tire the
other day," he said.
	- http://tinyurl.com/h6fo
