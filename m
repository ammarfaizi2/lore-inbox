Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265978AbUIVRaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265978AbUIVRaP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 13:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbUIVRaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 13:30:15 -0400
Received: from mailfe08.swip.net ([212.247.154.225]:2008 "EHLO
	mailfe08.swip.net") by vger.kernel.org with ESMTP id S265978AbUIVRaL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 13:30:11 -0400
X-T2-Posting-ID: Dj61D68IeDuIH178uA3nkQ==
Date: Wed, 22 Sep 2004 19:48:43 +0200
From: sledgedog <sledgedog@free.fr>
To: linux-kernel@vger.kernel.org
Subject: Javascript bug with 2.6.8.1
Message-Id: <20040922194843.0804de30.sledgedog@free.fr>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



hi,

the error occurs with any navigator and only with the kernel 2.6.8
the javascript on an https interactive site of a bank won't display the full page 
and hang in the middle .

But with the kernel 2.6.7 on same machine with same programs there is no problem
the full page is displayed.


I can reproduce the problem on different machines.



I'd like  to be personally CC'ed the answers/comments posted to the list in response to my posting.


Thanks
