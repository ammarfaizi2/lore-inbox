Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130685AbRCTUOd>; Tue, 20 Mar 2001 15:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130733AbRCTUOX>; Tue, 20 Mar 2001 15:14:23 -0500
Received: from mx.interplus.ro ([193.231.252.3]:4624 "EHLO mx.interplus.ro")
	by vger.kernel.org with ESMTP id <S130685AbRCTUOO>;
	Tue, 20 Mar 2001 15:14:14 -0500
Message-ID: <3AB7BA02.9E29FF4B@interplus.ro>
Date: Tue, 20 Mar 2001 22:13:54 +0200
From: Mircea Ciocan <mirceac@interplus.ro>
Organization: Home Office
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac18 i686)
X-Accept-Language: ro, en
MIME-Version: 1.0
To: georg@redwave.net
CC: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Problems with SCSI controller !!!
In-Reply-To: <Pine.LNX.4.05.10103202024310.4053-100000@callisto.of.borg>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

		Hello everybody,

	This is a message on behalf of a friend that is not subscribed to list:

	It's about an ASUS board that has this ncr53-1010 dual 160 SCSI
controller (sym53c1010).
	On both latest kernels (2.2.18ac19 AND 2.4.2ac18) the log and console
is filled with that:

	sym53c1010-33-0: unable to abort current chip operation.
	sym53c1010-33-0: Downloading SCSI SCRIPTS.
	sym53c8xx_reset: pid=0 reset_flags=2 ...

	and the controller suddenly blocks and the system have be restarted.

	Do someone know the meaning of this messages and what's matter, do you
want more details and what else ???

			Regards,
			
			Mircea C.
