Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbTJGQl4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 12:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262508AbTJGQl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 12:41:56 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:40328 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S262507AbTJGQlz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 12:41:55 -0400
Message-ID: <3F82EB1A.8030609@rackable.com>
Date: Tue, 07 Oct 2003 09:34:34 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tigran@aivazian.fsnet.co.uk
CC: Thomas Horsten <thomas@horsten.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.4.XX] Silicon Image/CMD Medley Software RAID
References: <8393446.1065535371042.JavaMail.www@wwinf3002>
In-Reply-To: <8393446.1065535371042.JavaMail.www@wwinf3002>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Oct 2003 16:41:53.0638 (UTC) FILETIME=[E9F0B860:01C38CF1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tigran@aivazian.fsnet.co.uk wrote:
> 
> so horrendously slow, without even using any of its RAID functions (which
> would be slow understandably as they are software RAID)?

   There isn't any reason for software raid to be slower than hardware 
raid.  On the 3ware ide raid controller.  Linux software raid 5 is 
easily x2 as fast as hardware raid 5 on the same controller.




-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>

