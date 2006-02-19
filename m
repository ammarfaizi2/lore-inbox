Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWBSShs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWBSShs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 13:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWBSShs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 13:37:48 -0500
Received: from c-66-31-106-233.hsd1.ma.comcast.net ([66.31.106.233]:40864 "EHLO
	nwo.kernelslacker.org") by vger.kernel.org with ESMTP
	id S932191AbWBSShr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 13:37:47 -0500
Date: Sun, 19 Feb 2006 13:37:25 -0500
From: Dave Jones <davej@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: don't bother users with unimportant messages.
Message-ID: <20060219183725.GC32492@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060219010910.GA18841@redhat.com> <20060219081523.GA9668@flint.arm.linux.org.uk> <20060219082916.GA19903@redhat.com> <20060219175745.GB2674@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219175745.GB2674@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 09:57:45AM -0800, Greg Kroah-Hartman wrote:

 > >  > If you're getting complaints about this, wouldn't it be better to
 > >  > forward them here so that they can be fixed up?
 > > 
 > > w83627hf, and probably other drivers from drivers/hwmon/
 > 
 > With 2.6.16-rc4?  I thought I just sent a patch in for -rc3 to fix this.

Yep, user was running an older kernel.
Much ado about nothing..

Thanks,

		Dave

