Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272533AbRI3De7>; Sat, 29 Sep 2001 23:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272451AbRI3Deu>; Sat, 29 Sep 2001 23:34:50 -0400
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:273 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S272449AbRI3Dem>;
	Sat, 29 Sep 2001 23:34:42 -0400
Message-ID: <3BB6933A.5010905@si.rr.com>
Date: Sat, 29 Sep 2001 23:36:26 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: alan@lxorguk.ukuu.org.uk
Subject: 2.4.9-ac18: __cpu_raise_softirq constantly redefined
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
     While building 2.4.9-ac18, I constantly received the warning that ' 
__cpu_raise_softirq redefined'. I didn't notice the warning while 
building 2.4.9-ac17.

gcc version 2.91.66

Regards,
Frank

