Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbUAVSEf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 13:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266271AbUAVSEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 13:04:35 -0500
Received: from ishtar.tlinx.org ([64.81.58.33]:40064 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S264881AbUAVSEe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 13:04:34 -0500
Message-ID: <4010108F.2090408@tlinx.org>
Date: Thu, 22 Jan 2004 10:03:59 -0800
From: law <lkml@tlinx.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: utf8 or utf-8
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I notice in the 2.4 configuration utilities there are places where I

have "utf-8"
for a default code page, but there are other places that use "UTF8".  It may
seem an idiotic question, but does the dash ("-") create significance?  
Should
all references be UTF8 or utf-8?

I notice under the SuSE 9.0 locale files, the dash seems significant and 
it won't
find the right locale files if you put utf8 in some places.

Thanks,

Please Cc me on copies as I'm currently not on the list (kept getting 
kicked off
due to transient and occasional mail-bounce problems).

-l







