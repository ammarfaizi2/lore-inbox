Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135919AbRDTSFt>; Fri, 20 Apr 2001 14:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135905AbRDTSFh>; Fri, 20 Apr 2001 14:05:37 -0400
Received: from www.ansp.br ([143.108.25.7]:48146 "HELO www.ansp.br")
	by vger.kernel.org with SMTP id <S135904AbRDTSFV>;
	Fri, 20 Apr 2001 14:05:21 -0400
Message-ID: <3AE07A5A.C5BBE59C@ansp.br>
Date: Fri, 20 Apr 2001 15:05:14 -0300
From: Marcus Ramos <marcus@ansp.br>
Organization: Fapesp
X-Mailer: Mozilla 4.73 [en] (X11; I; FreeBSD 4.1-RELEASE i386)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: What is the precision of usleep ?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am using usleep in an application under RH7 kernel 2.4.2. However,
when I bring its argument down to 20 miliseconds (20.000 microseconds)
or less, this seems to be ignored by the function (or the machine's hw
timer), which behaves as if 20 ms where its lowest acceptable value. How
can I measure the precision of usleep in my box ? I am currently using
an Dell GX110 PIII 866 MHz.

Thanks in advance.
Marcus.
