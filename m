Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbTENPMg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 11:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbTENPMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 11:12:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33758 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262456AbTENPKM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 11:10:12 -0400
Date: Wed, 14 May 2003 16:22:55 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Pau Aliagas <linuxnow@newtral.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ahmed Masud <masud@googgun.com>,
       walt <wa1ter@myrealbox.com>
Subject: Re: cannot boot 2.5.69
Message-ID: <20030514152255.GY10374@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.33.0305141025010.10993-100000@marauder.googgun.com> <Pine.LNX.4.44.0305141633540.1872-100000@pau.intranet.ct>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305141633540.1872-100000@pau.intranet.ct>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 04:36:26PM +0200, Pau Aliagas wrote:
> On Wed, 14 May 2003, Ahmed Masud wrote:
> 
> > On Wed, 14 May 2003, walt wrote:
> > 
> > > Pau Aliagas wrote:
> > > > I still find no way to boot a 2.5.69 kernel.
> > > > It reports: "no console found, specify init= option"
> > 
> > Looks as if init can't seem to find the device node file... Check your
> > /dev to see if there is a console entry there:
> > 
> > 	/dev/console c 5 1
> 
> That's exactly what I have and still no way.
> 
> > This isn't a kernel issue.
> 
> Well, I'm looking for a bit of help to test 2.5 kernels in several 
> machines (laptops, servers, desktops) because I have not been able to 
> solve this problem.

What kind of console do you have configured in and what's your kernel
command line?
