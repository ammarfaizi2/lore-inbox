Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266320AbTAFI5L>; Mon, 6 Jan 2003 03:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266322AbTAFI5L>; Mon, 6 Jan 2003 03:57:11 -0500
Received: from f175.sea1.hotmail.com ([207.68.163.175]:45072 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S266320AbTAFI5K>;
	Mon, 6 Jan 2003 03:57:10 -0500
X-Originating-IP: [196.44.34.77]
From: "Dirk Bull" <dirkbull102@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: shmat problem
Date: Mon, 06 Jan 2003 09:05:37 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F175L4BapMJJGizFJ0q0002fff7@hotmail.com>
X-OriginalArrivalTime: 06 Jan 2003 09:05:38.0114 (UTC) FILETIME=[C7ABC220:01C2B562]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi all

I have a problem with the shmat() function. It works correctly when
one doesn't specify an address where the segment should be attached,
but fails when one does. To specify an address it must be alligned
and I did by using  __attribute__ (aligned()). Still the function
fails. What is the most effective way for a solution
to this problem.

Thanks
Dirk


_________________________________________________________________
Add photos to your e-mail with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail

