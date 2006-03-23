Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbWCWBXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWCWBXm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 20:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWCWBXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 20:23:42 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:27411 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750932AbWCWBXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 20:23:41 -0500
Message-ID: <4421F89A.2070406@vmware.com>
Date: Wed, 22 Mar 2006 17:23:38 -0800
From: Kalyan Rajasekharuni <kalyan@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Triggering Machine Check Exceptions on x86
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Mar 2006 01:23:39.0319 (UTC) FILETIME=[6A1E4C70:01C64E18]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to trigger a Machine Check Exception soley by a 
'software mechanism' on my x86 box. The idea is to test my 
machine check exception handler thoroughly. I want a reliable 
way which will generate this exception every time when I run 
the software code snippet. 


