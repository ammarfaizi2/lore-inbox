Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263557AbUCZRV0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 12:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263606AbUCZRV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 12:21:26 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:48529 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263557AbUCZRVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 12:21:23 -0500
Subject: Re: Migrate pages from a ccNUMA node to another - patch
From: Dave Hansen <haveblue@us.ibm.com>
To: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
Cc: linux-ia64@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4063F581.ACC5C511@nospam.org>
References: <4063F581.ACC5C511@nospam.org>
Content-Type: text/plain
Message-Id: <1080321646.31638.105.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 26 Mar 2004 09:20:46 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you considered any common ground your patch might share with the
people doing memory hotplug?

	http://people.valinux.co.jp/~iwamoto/mh.html

They have a similar problem to your migration that occurs when a user
wants to remove a whole or partial NUMA node.  
lhms-devel@lists.sourceforge.net

Is your code something that you'd like to see go into the mainline 2.6
or 2.7 kernel?  

Also, please don't spam-encode your address when sending to the list. 
It just makes it harder for people to send feedback.  

-- Dave

