Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVBNEGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVBNEGx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 23:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVBNEGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 23:06:53 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:41427 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261337AbVBNEGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 23:06:52 -0500
Subject: Re: [ANNOUNCE] hotplug-ng 001 release
From: Lee Revell <rlrevell@joe-job.com>
To: Greg KH <gregkh@suse.de>
Cc: Patrick McFarland <pmcfarland@downeast.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050211011609.GA27176@suse.de>
References: <20050211004033.GA26624@suse.de> <420C054B.1070502@downeast.net>
	 <20050211011609.GA27176@suse.de>
Content-Type: text/plain
Date: Sun, 13 Feb 2005 23:06:51 -0500
Message-Id: <1108354011.25912.43.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-10 at 17:16 -0800, Greg KH wrote:
> All distros are trying to reduce boot time.

They certainly aren't all trying very hard.  Debian and Fedora (last
time I checked) do not even run the init scripts in parallel.

Lee

