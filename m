Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264490AbUEDQZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264490AbUEDQZl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 12:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264502AbUEDQZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 12:25:41 -0400
Received: from mail.kroah.org ([65.200.24.183]:49349 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264490AbUEDQZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 12:25:39 -0400
Date: Tue, 4 May 2004 09:22:52 -0700
From: Greg KH <greg@kroah.com>
To: Alexander ZVYAGIN <Alexander.Zviagine@cern.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with USB/Sound.
Message-ID: <20040504162252.GC20453@kroah.com>
References: <200405041135.55950.Alexander.Zviagine@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405041135.55950.Alexander.Zviagine@cern.ch>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2004 at 11:35:55AM +0200, Alexander ZVYAGIN wrote:
> Hello,
> 
> It seems that linux  2.6.5 has some problems with my USB ports...
> See config-1, dmesg-1.
> 
> Whatever I connect to the USB ports, I see no reaction at all.

Care to file a bug at bugzilla.kernel.org for this?

Also, don't attach your log files to the bug in compressed form, makes
it a lot harder to read...

thanks,

greg k-h
