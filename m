Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266633AbSKZTca>; Tue, 26 Nov 2002 14:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266626AbSKZTcA>; Tue, 26 Nov 2002 14:32:00 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:29392 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S266627AbSKZTbx>; Tue, 26 Nov 2002 14:31:53 -0500
Message-ID: <3DE3CDD7.1040202@nortelnetworks.com>
Date: Tue, 26 Nov 2002 14:39:03 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Richard B. Tilley (Brad)" <rtilley@vt.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compiler & Statically Linked Question
References: <1038336619.7793.28.camel@oubop4.bursar.vt.edu> 	<3DE3C79C.20306@nortelnetworks.com> <1038338424.7794.43.camel@oubop4.bursar.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Tilley (Brad) wrote:

> So, if the compiler on the build system was gcc-3.2 and the c library
> was glibc-2.2.x, then it would not matter if the compiler and c library 
> on the install systems were of differing versions? Is this what you
> mean?

Correct.  The kernel is totally self-sufficient and does not use the C 
library.

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

