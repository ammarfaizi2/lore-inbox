Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750987AbWCSU5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWCSU5h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 15:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWCSU5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 15:57:37 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:18384 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1750978AbWCSU5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 15:57:37 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: OOPS: 2.6.16-rc6 cpufreq_conservative
Date: Sun, 19 Mar 2006 15:57:37 -0500
User-Agent: KMail/1.9.1
Cc: Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, alex-kernel@digriz.org.uk,
       jun.nakajima@intel.com, davej@redhat.com
References: <200603181525.14127.kernel-stuff@comcast.net> <Pine.LNX.4.64.0603191148160.3826@g5.osdl.org> <Pine.LNX.4.64.0603191217560.3826@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603191217560.3826@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603191557.37437.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 March 2006 15:31, Linus Torvalds wrote:
> In the meantime, people who are
> interested can test out how much difference the trivial patch makes for
> them..

4464 bytes saving in text size for me on x86 - boots and seems to work fine.

Parag
