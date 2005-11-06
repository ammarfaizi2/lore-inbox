Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbVKFWIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbVKFWIX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 17:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbVKFWIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 17:08:22 -0500
Received: from [81.2.110.250] ([81.2.110.250]:15836 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932226AbVKFWIW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 17:08:22 -0500
Subject: Re: [ANNOUNCE] Ubuntu kernel tree
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Drake <dsd@gentoo.org>
Cc: Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
In-Reply-To: <436E17CA.3060803@gentoo.org>
References: <20051106013752.GA13368@swissdisk.com>
	 <436E17CA.3060803@gentoo.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 06 Nov 2005 22:38:49 +0000
Message-Id: <1131316729.1212.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-11-06 at 14:48 +0000, Daniel Drake wrote:
> Do other distros publish their trees anywhere? It would be handy to collect 
> links and publish them in an article on distrodev.org or some place like that. 
> (are there any kernel wikis?)
> 
> I try to 'open' Gentoo's kernel patchset at http://dev.gentoo.org/~dsd/genpatches

The FC kernel trees rpms and source rpms are distributed from the fedora
site. 'Production' kernels go to the updates directory, others which are
intended for testing go to the update testing directory and may or may
not work wonderfully.

RHEL kernel source trees are also on redhat.com, although I suspect they
are of somewhat limited interest to most of the development community.

