Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266369AbUAHXcD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 18:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266370AbUAHXcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 18:32:02 -0500
Received: from smtp3.akamai.com ([63.116.109.25]:21245 "EHLO
	fozzie.sanmateo.corp.akamai.com") by vger.kernel.org with ESMTP
	id S266369AbUAHXcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 18:32:01 -0500
Message-ID: <3FFDF78B.EA49E195@akamai.com>
Date: Thu, 08 Jan 2004 16:36:27 -0800
From: Prasanna Meda <pmeda@akamai.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: madan@nmsworks.co.in
CC: linux-kernel@vger.kernel.org, gowri@ittc.ukans.edu
Subject: Re: doubt in netlink sockets
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In reference to
   http://www.ussg.iu.edu/hypermail/linux/kernel/0301.0/1341.html
   http://qos.ittc.ukans.edu/netlink/html/netlink.html

You did not set the needed rtm_dst_len field. See the section 3.1.1
in  http://www.faqs.org/rfcs/rfc3549.html

Thanks,
Prasanna.

