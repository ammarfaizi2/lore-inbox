Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbVHLCkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbVHLCkh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 22:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbVHLCkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 22:40:37 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:450 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750755AbVHLCkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 22:40:37 -0400
Subject: Re: Wireless support
From: Lee Revell <rlrevell@joe-job.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Jochen Friedrich <jochen@scram.de>, Adrian Bunk <bunk@stusta.de>,
       abonilla@linuxwireless.org, "'Andreas Steinmetz'" <ast@domdv.de>,
       "'Arjan van de Ven'" <arjan@infradead.org>,
       "'Denis Vlasenko'" <vda@ilport.com.ua>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
In-Reply-To: <AC074A82-2B17-485A-9BFE-090CB4EE6E44@mac.com>
References: <005501c59c4a$f6210800$a20cc60a@amer.sykes.com>
	 <1123528018.15269.44.camel@mindpipe> <20050808232957.GR4006@stusta.de>
	 <42F872E3.3050106@scram.de>  <AC074A82-2B17-485A-9BFE-090CB4EE6E44@mac.com>
Content-Type: text/plain
Date: Thu, 11 Aug 2005 22:40:31 -0400
Message-Id: <1123814434.26878.21.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.7 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-09 at 09:52 -0400, Kyle Moffett wrote:
> they are much less likely to participate in any kind of reverse  
> engineering effort, even if it's just testing a new driver.

I think anyone launching a reverse engineering effort should announce
the project to LKML!  When I set out to add some multichannel
functionality to the emu10k1 ALSA drivers based on the kX project
Windows drivers, I announced the project to alsa-devel and alsa-user,
and got a number of volunteers who were most helpful in testing these
new features, and greatly sped up the effort.  As a result we were able
to fix almost all the major bugs before I even submitted the patch.  Now
these new features are merged as of ALSA 1.0.9.

There is a very large group of people who can't write code but have the
hardware and are dying to get more out of it, or just to get it to work,
and would gladly help any Linux driver reverse engineering project, if
they just knew about it.

Lee

