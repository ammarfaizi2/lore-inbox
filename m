Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbTIMNJY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 09:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262142AbTIMNJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 09:09:24 -0400
Received: from mail.telpin.com.ar ([200.43.18.243]:8637 "EHLO
	mail.telpin.com.ar") by vger.kernel.org with ESMTP id S262141AbTIMNJX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 09:09:23 -0400
Date: Sat, 13 Sep 2003 10:09:16 -0300
From: Alberto Bertogli <albertogli@telpin.com.ar>
To: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: file_lock_cache won't shink down
Message-ID: <20030913130916.GE22369@telpin.com.ar>
Mail-Followup-To: Alberto Bertogli <albertogli@telpin.com.ar>,
	Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
References: <20030913005123.GE21596@parcelfarce.linux.theplanet.co.uk> <20030913065914.GD22369@telpin.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030913065914.GD22369@telpin.com.ar>
User-Agent: Mutt/1.5.4i
X-RAVMilter-Version: 8.4.2(snapshot 20021217) (mail)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 03:59:14AM -0300, Alberto Bertogli wrote:
> On Sat, Sep 13, 2003 at 01:51:23AM +0100, Matthew Wilcox wrote:
> > Hi, Alberto.  Please try
> > http://ftp.linux.org.uk/pub/linux/willy/patches/flock-memleak.diff
> 
> I've just put it in, it seems to be working so far but I'll tell you
> tomorrow for sure after it's been under some pressure.

It's been tested enough to confirm that it's working great!

Thanks a lot for the patch, I really hope this goes into mainline as it
fixes a very serious and easily reproduceable bug.


Thanks again,
		Alberto


