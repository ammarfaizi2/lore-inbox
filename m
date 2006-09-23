Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbWIWU4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbWIWU4Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 16:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbWIWU4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 16:56:25 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:25031 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964918AbWIWU4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 16:56:25 -0400
Subject: Re: Linux 2.6.16.30-pre1
From: Lee Revell <rlrevell@joe-job.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: Adrian Bunk <bunk@stusta.de>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060923224909.69579243.khali@linux-fr.org>
References: <20060922222300.GA5566@stusta.de>
	 <20060922223859.GB21772@kroah.com> <20060922224735.GB5566@stusta.de>
	 <20060922230928.GB22830@kroah.com>
	 <20060923224909.69579243.khali@linux-fr.org>
Content-Type: text/plain
Date: Sat, 23 Sep 2006 16:57:56 -0400
Message-Id: <1159045077.1097.182.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-23 at 22:49 +0200, Jean Delvare wrote:
> I will not use 2.6.16.y with its current rules, for sure, and I doubt
> any distribution will. Wasn't the whole point of 2.6.16.y to serve as
> a common base between several distributions? 

I would not expect distros to be interested in a 2.6 tree that does not
add support for new devices.  Isn't new hardware support one of the main
areas where distros routinely get ahead of mainline?

Lee

