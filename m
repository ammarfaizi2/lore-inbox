Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030338AbWBVXPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030338AbWBVXPk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 18:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030342AbWBVXPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 18:15:40 -0500
Received: from master.soleranetworks.com ([67.137.28.188]:29582 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S1030338AbWBVXPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 18:15:39 -0500
Message-ID: <43FCFDC6.9090109@soleranetworks.com>
Date: Wed, 22 Feb 2006 17:11:50 -0700
From: "Jeff V. Merkey" <jmerkey@soleranetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Red Hat ES4 GPL Issues?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have been working on 2.6.9 kernels with red hat ES4 series 
distributions (we purchased and have a license).  I noticed that the ES4 
series kernels
which support NPTL libs no longer provide the source code with the 
distribution (the installed kernels sources point to empty source trees 
which
only contain makefiles).   I have discovered we have to use our Red Hat 
Network account in order to download the Source RPMs
(which are in fact provided).

We got the distro via electronic fullfilment, so we did not get the 
SRPMS CD iso images by default.  This was a deviation from how Red Hat
normally distributes source code with their Linux distro.

I am curious if Red Hat views requiring people subscribing to RHN as a 
requirement to obtain source code is in conflict with the GPL.  We
have no objection to downloading it since we have an account, but I 
found it strange Red Hat, the leaders in Open Source and GPL
technology, now appear to block downloads of ES4 source code without a 
subscription.  Have I got it all wrong here, or is this borderline GPL
avoidance?

I am unable to locate the Source Code on any public servers at Red Hat.

Jeff

