Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbVCCVpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVCCVpF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 16:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbVCCVns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 16:43:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7087 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261720AbVCCV33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 16:29:29 -0500
Message-ID: <42278194.7020409@pobox.com>
Date: Thu, 03 Mar 2005 16:28:52 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Dave Jones <davej@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, greg@kroah.com, torvalds@osdl.org,
       rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002047.GA10434@kroah.com> <Pine.LNX.4.58.0503021710430.25732@ppc970.osdl.org> <20050303081958.GA29524@kroah.com> <4226CCFE.2090506@pobox.com> <20050303090106.GC29955@kroah.com> <4226D655.2040902@pobox.com> <20050303021506.137ce222.akpm@osdl.org> <20050303170759.GA17742@ti64.telemetry-investments.com> <20050303193358.GA29371@redhat.com> <20050303203808.GA10408@ti64.telemetry-investments.com>
In-Reply-To: <20050303203808.GA10408@ti64.telemetry-investments.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Rugolsky Jr. wrote:
> I've watched you periodically announce "hey, I'm doing an update for
> FC3/FC2, please test" on the mail list, and a handful of people go test.
> If we could convince many of the the less risk-averse but lazy users to
> grab kernels automatically from updates/3/testing/ or updates/3/unstable/
> as part of "yum update", and have a way to manage the plethora of (even
> daily) kernel updates by removing old unused kernels, then we'd only
> have to convince them *once* to set up their YUM repos, and then get them
> to poweroff or reboot [or use a Xen domain] occasionally. :-)


Tangent:  I would like to see requests-for-testing for FC kernels on LKML.

If people announce -ac/-as/-aa/-ck/etc. kernels on LKML, why not distro 
kernels?

	Jeff


