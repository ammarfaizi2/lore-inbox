Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292130AbSDAA7h>; Sun, 31 Mar 2002 19:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292229AbSDAA7R>; Sun, 31 Mar 2002 19:59:17 -0500
Received: from viefep13-int.chello.at ([213.46.255.15]:33058 "EHLO
	viefep13-int.chello.at") by vger.kernel.org with ESMTP
	id <S292130AbSDAA7I>; Sun, 31 Mar 2002 19:59:08 -0500
From: "Thomas Michael Wanka" <Thomas@Wanka.at>
To: linux-kernel@vger.kernel.org
Date: Mon, 1 Apr 2002 03:01:40 +0200
MIME-Version: 1.0
Subject: 2.4.18 highmem smp freeze
Message-ID: <3CA7CD94.27390.74FD378@localhost>
X-mailer: Pegasus Mail for Windows (v4.01)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here are some people (including me) with smp and more than 1GB Ram 
(most Serverworks chipsets, have not jet seen it with AMDs MPX) where 
after some time (from hours to weeks probably load dependent) it 
seems there is nothing written to disk anymore and in the end the 
system completely freezes. This with several 2.4.x kernels (2.4.4, 
2.4.10, 2.4.16, 2.4.17 and 2.4.18).

I think this has been discussed here, but I am too stupid to 
understand it and/or find the solution.

I browsed the archives of the last year, and I think it was suggested 
to use 2.4.17rc2aa1 or aa2. Is this correct and will it solve the 
problem (IIRC there was no success message)? Will the later 2.2 
kernels show this behavior too (like 2.2.20)?

Thank you in advance and please cc me,

Thomas Michael Wanka
1080 Vienna, Austria
Please treat my personal data confidential



