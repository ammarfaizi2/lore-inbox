Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbTLECiS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 21:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbTLECiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 21:38:18 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:61611 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S261879AbTLECiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 21:38:17 -0500
Date: Thu, 4 Dec 2003 18:38:11 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa1
Message-ID: <20031205023811.GK29119@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	linux-kernel@vger.kernel.org
References: <20031205022225.GA1565@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031205022225.GA1565@dualathlon.random>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 03:22:25AM +0100, Andrea Arcangeli wrote:
> Only in 2.4.23pre6aa3: 90_ext3-commit-interval-5
> 
> 	Obsoleted by the laptop mode (I hope it's "fully" obsoleted ;).
> 

Maybe not.  I saw one report here on lkml that showed that
ext3-commit-interval is still needed even with laptop mode. :(
