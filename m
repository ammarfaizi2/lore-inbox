Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131354AbQLMNop>; Wed, 13 Dec 2000 08:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131424AbQLMNof>; Wed, 13 Dec 2000 08:44:35 -0500
Received: from vega.digitel2002.hu ([213.163.0.181]:2317 "EHLO
	vega.digitel2002.hu") by vger.kernel.org with ESMTP
	id <S131354AbQLMNoU>; Wed, 13 Dec 2000 08:44:20 -0500
Date: Wed, 13 Dec 2000 14:13:51 +0100
To: linux-kernel@vger.kernel.org
Subject: strange directory problem
Message-ID: <20001213141350.B8330@vega.digitel2002.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
X-Operating-System: vega Linux 2.2.18pre24 i686
From: Gabor Lenart <lgb@vega.digitel2002.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

lgb@vega:~$ uname -a
Linux vega 2.2.18pre24 #1 Thu Dec 7 14:08:36 CET 2000 i686 unknown

I created a directory from shell (bash). The next ls didn't show it,
I had to type ls second time too to get the changes. Is it a known bug?
Is it fixed in 2.2.18final ?

-- 
 --[ Gábor Lénárt ]---[ Vivendi Telecom Hungary ]--[ lgb@supervisor.hu ]--
 U have 8 bit comp or chip of them and it's unused or to be sold? Call me!
 -------[ +36 30 2270823 ]------> LGB <-----[ Linux/UNIX/8bit 4ever ]-----
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
