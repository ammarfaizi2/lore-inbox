Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWEIVxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWEIVxy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 17:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWEIVxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 17:53:54 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:29314 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751186AbWEIVxx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 17:53:53 -0400
Date: Tue, 9 May 2006 14:56:55 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Chris Wright <chrisw@sous-sol.org>, xen-devel@lists.xensource.com,
       linux-kernel@vger.kernel.org, Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 15/35] subarch support for controlling interrupt delivery
Message-ID: <20060509215655.GV24291@moss.sous-sol.org>
References: <20060509084945.373541000@sous-sol.org> <200605091807.57522.ak@suse.de> <20060509162959.GL7834@cl.cam.ac.uk> <200605091831.37757.ak@suse.de> <20060509204207.GQ7834@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509204207.GQ7834@cl.cam.ac.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christian Limpach (Christian.Limpach@cl.cam.ac.uk) wrote:
> Everything[1] in line:
> -rwxr-xr-x  1 cl349 cl349  2633640 May  9 19:42 vmlinux-inline-stripped
> Everything out of line:
> -rwxr-xr-x  1 cl349 cl349  2621352 May  9 19:45 vmlinux-outline-stripped

Have the output of 'size vmlinux*' handy?  Be nice to get the extra
details.

thanks,
-chris
