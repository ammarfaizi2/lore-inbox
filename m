Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267377AbUJSVa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267377AbUJSVa6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 17:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267497AbUJSVLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 17:11:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:25500 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267327AbUJSU6m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 16:58:42 -0400
Message-ID: <41758014.4080502@osdl.org>
Date: Tue, 19 Oct 2004 13:59:00 -0700
From: Stephen Hemminger <shemminger@osdl.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: netdev@oss.sgi.com, linux-net@vger.kernel.org, LARTC@mailman.ds9a.nl
Subject: [ANNOUNCE] iproute2 2.6.9-041019
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that 2.6.9 is final. Here is an update of the iproute2 utilities 
that contains
all the patches in my queue. 

    * lnstat to replace rtstat and ctstat (from Harald Welte)
    * latest xfrm related changes
    * several small typo's and build fixes for older systems

http://developer.osdl.org/dev/iproute2/download/iproute2-2.6.9-041019.tar.gz
