Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135268AbRECWMG>; Thu, 3 May 2001 18:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135266AbRECWL4>; Thu, 3 May 2001 18:11:56 -0400
Received: from mail.ureach.com ([63.150.151.36]:34830 "EHLO ureach.com")
	by vger.kernel.org with ESMTP id <S135268AbRECWLo>;
	Thu, 3 May 2001 18:11:44 -0400
Date: Thu, 3 May 2001 18:11:43 -0400
Message-Id: <200105032211.SAA08879@www23.ureach.com>
To: linux-kernel@vger.kernel.org
From: Kapish K <kapish@ureach.com>
Reply-to: <kapish@ureach.com>
Subject: nfs debug??
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-vsuite-type: e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
	I am trying to be be able to debug nfsd to be able to find out
the slow response times for the performance tests - I am able to
set up all the required debug levels (d epending on nfs
components in /proc/sys/sunrpc/nfsd_debug ), but I want to
disable logging to console, as that eats up my console space...I
want it to just log to log/messages. But I do not seem to eb
abelt o do so, either with kernel boot options or with any
configuration of syslog/klog, etc.
Any pointers?
Thanks

________________________________________________
Get your own "800" number
Voicemail, fax, email, and a lot more
http://www.ureach.com/reg/tag
