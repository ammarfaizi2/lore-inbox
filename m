Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbVCJC1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVCJC1H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 21:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbVCJC0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 21:26:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50054 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261158AbVCJCXS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 21:23:18 -0500
Date: Wed, 9 Mar 2005 21:23:05 -0500
From: Dave Jones <davej@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, rddunlap@osdl.org
Subject: Re: [PATCH] Add 2.4.x cpufreq /proc and sysctl interface removal feature-removal-schedule
Message-ID: <20050310022304.GE8128@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, rddunlap@osdl.org
References: <11104148771738@kroah.com> <1110414878721@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110414878721@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 04:34:38PM -0800, Greg KH wrote:
 > ChangeSet 1.2036, 2005/03/09 09:31:40-08:00, rddunlap@osdl.org
 > 
 > [PATCH] Add 2.4.x cpufreq /proc and sysctl interface removal feature-removal-schedule
 > 
 > Add 2.4.x cpufreq /proc and sysctl interface removal
 > to the feature-removal-schedule.
 > 
 > Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
 > Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>
 > 
 > 
 >  Documentation/feature-removal-schedule.txt |    9 +++++++++
 >  1 files changed, 9 insertions(+)
 > 
 > 
 > diff -Nru a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
 > --- a/Documentation/feature-removal-schedule.txt	2005-03-09 16:30:16 -08:00
 > +++ b/Documentation/feature-removal-schedule.txt	2005-03-09 16:30:16 -08:00
 > @@ -15,3 +15,12 @@
 >  	against the LSB, and can be replaced by using udev.
 >  Who:	Greg Kroah-Hartman <greg@kroah.com>
 >  
 > +---------------------------
 > +
 > +What:	/proc/sys/cpu and the sysctl interface to cpufreq (2.4.x interfaces)
 > +When:	January 2005

You're about 2 months too late 8-)

		Dave

