Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbULTRxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbULTRxx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 12:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbULTRxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 12:53:53 -0500
Received: from main.gmane.org ([80.91.229.2]:25516 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261591AbULTRvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 12:51:08 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Adam Sherman <adam@sherman.ca>
Subject: unregister_netdevice: waiting for eth0.2 to become free. Usage count
 = 1
Date: Mon, 20 Dec 2004 12:50:40 -0500
Message-ID: <cq73dc$jdu$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: gw.techsupport.ca
User-Agent: Mozilla Thunderbird 1.0 (Macintosh/20041206)
X-Accept-Language: en-us, en
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I often get the following message when trying to shutdown systems 
running 2.6.8 & 2.6.9 (Debian sources). Seems to be related to VLAN use 
and also PPPoE over a VLAN interface. Any ideas for where to start looking?

unregister_netdevice: waiting for eth0.2 to become free. Usage count = 1

Thanks,

A.

