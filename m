Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264826AbUEEWoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264826AbUEEWoN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 18:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264833AbUEEWoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 18:44:13 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:11018 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S264826AbUEEWoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 18:44:12 -0400
Message-ID: <40996E3B.3040901@hp.com>
Date: Wed, 05 May 2004 15:44:11 -0700
From: John Byrne <john.l.byrne@hp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Switching console to text mode during panic
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm interested in patch to switch the 386 console to text mode during 
panic so I can see panic messages if I'm in X. My first attempts at this 
from looking at the code in vt.c didn't work, so I was wondering if 
someone could give me clue.

Thanks,

John Byrne


