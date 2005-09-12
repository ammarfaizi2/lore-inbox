Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbVILOZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbVILOZV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 10:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbVILOZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:25:21 -0400
Received: from smtp.ctyme.com ([209.237.228.12]:27308 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S1751018AbVILOZU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:25:20 -0400
Message-ID: <43258FC0.9040000@perkel.com>
Date: Mon, 12 Sep 2005 07:25:04 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.10) Gecko/20050716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Very strange ACL problem - SOLVED
References: <43244F46.70500@perkel.com>
In-Reply-To: <43244F46.70500@perkel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-filter-host: darwin.ctyme.com - http://www.junkemailfilter.com
X-Sender-host-address: 204.95.16.61
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yesterday I wrote about an ACL problem. I thought it was a strange 
kernel permissions issue. Turns out I had installed php-mmcache on my 
machine and whatever that does - it wasn't working. Removing it solved 
the problem.

Sorry about that.

