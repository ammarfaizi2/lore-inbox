Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269870AbUJHBlC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269870AbUJHBlC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 21:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269837AbUJHBbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 21:31:53 -0400
Received: from main.gmane.org ([80.91.229.2]:1706 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S269848AbUJHBai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 21:30:38 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ian Pilcher <i.pilcher@comcast.net>
Subject: kernel BUG at kernel/workqueue.c:104!
Date: Thu, 07 Oct 2004 20:20:39 -0500
Message-ID: <ck4q19$tne$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-0-215-208.client.comcast.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I hit this trying to install Fedora Core 3 test 1 or test 2.  Anyone
who's interested can see the output at:

     https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=127862

This is obviously one for Red Hat (although they appear massively
uninterested), but I was just wondering if anyone on this list can point
me towards a good spot to start digging.

Thanks!

-- 
========================================================================
Ian Pilcher                                        i.pilcher@comcast.net
========================================================================

