Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264829AbRFSXEr>; Tue, 19 Jun 2001 19:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264830AbRFSXEi>; Tue, 19 Jun 2001 19:04:38 -0400
Received: from wb2-a.mail.utexas.edu ([128.83.126.136]:35853 "HELO
	mail.utexas.edu") by vger.kernel.org with SMTP id <S264829AbRFSXEe>;
	Tue, 19 Jun 2001 19:04:34 -0400
Message-ID: <3B2F3194.D36843D7@mail.utexas.edu>
Date: Tue, 19 Jun 2001 17:03:48 +0600
From: "Bobby D. Bryant" <bdbryant@mail.utexas.edu>
Organization: (I do not speak for) The University of Texas at Austin (nor they for 
 me).
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac14 i686)
X-Accept-Language: en,fr,de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: "clock timer configuration lost" on non-VIA m.b.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.5-ac14 on an Asus A7A266 w/ Athlon:

...
Jun 19 16:14:21 pollux kernel: probable hardware bug: clock timer
configuration lost - probably a VIA686a motherboard.
Jun 19 16:14:21 pollux kernel: probable hardware bug: restoring chip
configuration.
...

According to the documentation, this is an ALi chipset:

Northbridge: ALi M1647

Southbridge: ALi M1535D+

The message appears irregularly, with a period varying between 10
minutes and an hour.

More system info available on request.

Bobby Bryant
Austin, Texas


