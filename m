Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262780AbUCJTlD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 14:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262801AbUCJTk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 14:40:57 -0500
Received: from postoffice02.Princeton.EDU ([128.112.130.38]:15816 "EHLO
	Princeton.EDU") by vger.kernel.org with ESMTP id S262780AbUCJTkY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 14:40:24 -0500
Message-ID: <404F6F52.2000202@cs.princeton.edu>
Date: Wed, 10 Mar 2004 14:41:06 -0500
From: KyoungSoo Park <kyoungso@cs.princeton.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: how to detect udp packets drops ?
References: <404E36F1.8000908@newsguy.com>
In-Reply-To: <404E36F1.8000908@newsguy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm not sure if my question is appropriate, but is there any way to 
directly detect
UDP packet drops in linux 2.4.x ?
I'd like to know how many UDP packets get actually dropped by the kernel 
for the overloaded time period.
Any suggestions?

Thanks,
KyoungSoo

