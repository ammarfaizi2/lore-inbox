Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVDSOV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVDSOV0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 10:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVDSOVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 10:21:25 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:33210 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261548AbVDSOVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 10:21:18 -0400
Date: Tue, 19 Apr 2005 16:20:23 +0200
From: bert hubert <ahu@ds9a.nl>
To: Chuck Wolber <chuckw@quantumlinux.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Development Model
Message-ID: <20050419142023.GA14968@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Chuck Wolber <chuckw@quantumlinux.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.60.0504182219360.6679@bailey.quantumlinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0504182219360.6679@bailey.quantumlinux.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> that (at least for now) no *MAJOR* "rip it out, stomp on it, burn it and 
> start over" parts of the kernel exist any longer? In other words, do you 

These ideas continue to exist. This is partly due to increasing skills of
developers but also to the changing environment. You'll find literally
scores of commits that say 'this was a good idea when were were limited to
1024 filedescriptor' or the like.

I think the tty layer has been ready to be ripped out and replaced for the
past 10 years though.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
