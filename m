Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132584AbRDOHQR>; Sun, 15 Apr 2001 03:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132585AbRDOHQI>; Sun, 15 Apr 2001 03:16:08 -0400
Received: from mailsrv1.dlink.com.tw ([210.66.49.71]:24848 "EHLO
	mailsrv1.dlink.com.tw") by vger.kernel.org with ESMTP
	id <S132584AbRDOHP7>; Sun, 15 Apr 2001 03:15:59 -0400
From: vivid_liou@dlink.com.tw
X-Lotus-FromDomain: D-LINK
To: linux-kernel@vger.kernel.org
Message-ID: <48256A2F.0027DD20.00@dlink.com.tw>
Date: Sun, 15 Apr 2001 15:19:52 +0800
Subject: how to compile multiplication and division operations not
	 supported by CPU
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dear All :

this question suppose not posted in the mailing list,since  I have  been posted
it on GNU compiler mailing list , and get no reponse. I posted it here to get
your help .
We licence MIPS CPU without MAC (the module support multiplication and division
functions).
For the convenience sake , we use ( *, / ) instead of (+ ,-)  in the c programs.
in  the gcc man document , this kind of function is not menstioned.
Does anyone meet the same question ,  and know how to solve it ?



