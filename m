Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbTIQMGU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 08:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbTIQMGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 08:06:20 -0400
Received: from sea2-f7.sea2.hotmail.com ([207.68.165.7]:516 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S262738AbTIQMGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 08:06:19 -0400
X-Originating-IP: [212.143.127.195]
X-Originating-Email: [zstingx@hotmail.com]
From: "sting sting" <zstingx@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: socketI implementation 
Date: Wed, 17 Sep 2003 15:06:18 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F7uqdcXqnviIvr0000be54@hotmail.com>
X-OriginalArrivalTime: 17 Sep 2003 12:06:18.0328 (UTC) FILETIME=[19DDA580:01C37D14]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I had downloaded the tar.gz of glibc;
I
I am interested in the learning the network layer and
implementation of  the socket API in glibc
(calls like socket,bind,gethostbyname,etc.).
I saw in the inet subdirectory on glibc that it seems that  these calls
are eventually result in calls to methods in nss subdirectory.

But I am not sure.
Am I right in my assumption?
or where I can find the implementation of methods like bind(), connect(), 
socket(), etc.

regards
sting

_________________________________________________________________
Help STOP SPAM with the new MSN 8 and get 2 months FREE*  
http://join.msn.com/?page=features/junkmail

