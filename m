Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130247AbQKNLOI>; Tue, 14 Nov 2000 06:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129891AbQKNLN6>; Tue, 14 Nov 2000 06:13:58 -0500
Received: from BDR-OSL-25-005.telenor.no ([134.47.108.13]:58891 "HELO
	bdr-osl-25-005.oslo.telenor.no") by vger.kernel.org with SMTP
	id <S129429AbQKNLNk>; Tue, 14 Nov 2000 06:13:40 -0500
Message-ID: <AF6FFF5F50E4D311B45A00A0245738C90FFC36@BDR-OSL-24-208>
From: svein-olav.bjerkeset@bravida.no
To: linux-kernel@vger.kernel.org
Subject: VM problem(?) in 2.2.17
Date: Tue, 14 Nov 2000 11:43:47 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

We have a Compaq server running RedHat Linux 6.2 with kernel 2.2.17
Once in a while we get errors like:

Nov 13 09:18:33 www2 kernel: VM: do_try_to_free_pages failed for httpd... 
Nov 13 09:18:43 www2 kernel: VM: do_try_to_free_pages failed for mysqld... 

The server then hangs and I have to cycle power to get it up and running
again.
Does anyone here know if 
  1. this is a known problem / bug?
  2. there is a patch available ?
  3. the problem is described anywhere else ?

Please CC to my e-mail as I am not subscribed to this list.


Regards
Svein Olav Bjerkeset
Systems Eng.
Bravida Norge AS
svein-olav.bjerkeset@bravida.no
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
