Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265226AbUFHP3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265226AbUFHP3h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 11:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265224AbUFHP3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 11:29:36 -0400
Received: from fmr05.intel.com ([134.134.136.6]:7603 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id S265225AbUFHP3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 11:29:35 -0400
From: Mark Gross <mgross@linux.jf.intel.com>
Organization: Intel
To: Pavel Machek <pavel@ucw.cz>
Subject: swsusp "not enough swap space" 2.6.5-mm6.
Date: Tue, 8 Jun 2004 08:29:35 -0700
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406080829.35120.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm sorry for not having more information, but the failing computer is my home 
laptop (I'll get more details after work or I'll bring it in tomorrow for 
more details).

Anyway, this thing does software suspend using the 2.6.2-mm1 kernel, and last 
night I was updating it to 2.6.5-mm6, and I started getting these not enough 
disk space errors.

I found your bug fix patch, 
http://marc.theaimsgroup.com/?l=linux-kernel&m=107806008626357&w=2
 and checked that it is included in the 2.6.5-mm6 kernel I'm using.

Without more information does this problem ring any bells?

Can you recommend a "good" kernel version that does reliable swsusp?

--mgross

