Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313032AbSDKXvT>; Thu, 11 Apr 2002 19:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313041AbSDKXvS>; Thu, 11 Apr 2002 19:51:18 -0400
Received: from NODE1.HOSTING-NETWORK.COM ([66.186.193.1]:26121 "HELO
	hosting-network.com") by vger.kernel.org with SMTP
	id <S313032AbSDKXvR>; Thu, 11 Apr 2002 19:51:17 -0400
Subject: measuring time spent in kernel
From: Torrey Hoffman <thoffman@arnor.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 11 Apr 2002 16:54:55 -0700
Message-Id: <1018569297.15331.4.camel@shire.arnor.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"top" and similar tools don't seem to capture the time spent in kernel
which isn't on behalf of a user process.

I vaguely remember mention on this list of a tool that soaks up as many
cycles as it can get to obtain an accurate measurement of the true
system time.

Can some one give me a pointer?  I've had no luck with Google...  

thanks,

Torrey Hoffman
thoffman@arnor.net
torrey.hoffman@myrio.com



