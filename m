Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbUCOMhu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 07:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbUCOMhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 07:37:50 -0500
Received: from alesia-4-82-66-59-64.fbx.proxad.net ([82.66.59.64]:41120 "HELO
	rooter.tripnotik.fr") by vger.kernel.org with SMTP id S262556AbUCOMht
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 07:37:49 -0500
X-Qmail-Scanner-Mail-From: jdidron@tripnotik.dyndns.org via rooter
X-Qmail-Scanner: 1.20 (Clear:RC:1(192.168.0.249):. Processed in 0.035282 secs)
Message-ID: <4055B06A.40002@tripnotik.dyndns.org>
Date: Mon, 15 Mar 2004 14:32:26 +0100
From: Julien Didron <jdidron@tripnotik.dyndns.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: about the mm2 patch for 2.6.4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

I noticed that patching the 2.6.4 kernel sources with the mm2 patch 
actually deletes scripts/fixdep.c, which results in a compilation error 
when building the bzImage.
I wouldn't be able to fix this though ...

TY

PS : This is my first post, so I don't know whether this is relevant, 
please excuse me if it's not. (and Yes I read the FAQ before posting 
this ;o)
