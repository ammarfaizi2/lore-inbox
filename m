Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267553AbUJIX2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267553AbUJIX2R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 19:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267554AbUJIX2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 19:28:17 -0400
Received: from gw.anda.ru ([212.57.164.72]:53508 "EHLO mail.ward.six")
	by vger.kernel.org with ESMTP id S267553AbUJIX2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 19:28:16 -0400
Date: Sun, 10 Oct 2004 05:28:09 +0600
From: Denis Zaitsev <zzz@anda.ru>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG][2.6.8.1] Something wrong with ISAPnP and serial driver
Message-ID: <20041010052809.C1639@natasha.ward.six>
Mail-Followup-To: Rene Herman <rene.herman@keyaccess.nl>,
	linux-kernel@vger.kernel.org
References: <20041010015206.A30047@natasha.ward.six> <4168479C.5080306@keyaccess.nl> <20041010033820.B30047@natasha.ward.six> <41685E04.3070103@keyaccess.nl> <20041010043443.A1639@natasha.ward.six> <41686A40.3060305@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41686A40.3060305@keyaccess.nl>; from rene.herman@keyaccess.nl on Sun, Oct 10, 2004 at 12:46:24AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 10, 2004 at 12:46:24AM +0200, Rene Herman wrote:
> Denis Zaitsev wrote:
> 
> > /proc/tty/driver/serial shows the correct info for now.  Does the fact
> > that it used to do not means that something wrong with sysfs PnP
> > activation mechanics?
> 
> That would appear to be the case yes. Adam Belay <ambx1@neo.rr.com> is 
> the person to talk to concerning PnP issues, if you care to.

Thanks.
