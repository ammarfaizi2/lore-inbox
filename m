Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751510AbWB0UXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbWB0UXZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 15:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWB0UXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 15:23:25 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:45323 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751516AbWB0UXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 15:23:24 -0500
Date: Mon, 27 Feb 2006 15:22:36 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Greg KH <gregkh@suse.de>
Cc: Benjamin LaHaise <bcrl@kvack.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, davej@redhat.com, perex@suse.cz,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Message-ID: <20060227202232.GC26559@tuxdriver.com>
Mail-Followup-To: Greg KH <gregkh@suse.de>,
	Benjamin LaHaise <bcrl@kvack.org>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, torvalds@osdl.org,
	Andrew Morton <akpm@osdl.org>, davej@redhat.com, perex@suse.cz,
	Kay Sievers <kay.sievers@vrfy.org>
References: <20060227190150.GA9121@kroah.com> <20060227193654.GA12788@kvack.org> <20060227194623.GC9991@suse.de> <20060227200107.GA14011@kvack.org> <20060227201323.GB12111@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060227201323.GB12111@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 12:13:23PM -0800, Greg KH wrote:

> Again, I agree.  People (including Linus) have said they will accept
> something like include/abi/ (it was a different name last time that I
> can't remember), but no one has done the work yet...

Whether or not something is in include/abi/*.h should be a factor in
classifying it as "stable", "unstable", etc...?

John
-- 
John W. Linville
linville@tuxdriver.com
