Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136088AbREGLbw>; Mon, 7 May 2001 07:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136091AbREGLbn>; Mon, 7 May 2001 07:31:43 -0400
Received: from hertz.ikp.physik.tu-darmstadt.de ([130.83.24.91]:12928 "EHLO
	hertz.ikp.physik.tu-darmstadt.de") by vger.kernel.org with ESMTP
	id <S136088AbREGLbb>; Mon, 7 May 2001 07:31:31 -0400
From: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15094.34704.397675.867882@hertz.ikp.physik.tu-darmstadt.de>
Date: Mon, 7 May 2001 13:31:28 +0200
To: linux-kernel@vger.kernel.org
CC: pochini@denise.shiny.it, alan@lxorguk.ukuu.org.uk
Subject: [Solved] Re: Problems even with 512 block size MOs
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

I am very sorry that I didn't mention that I ran Hubert Mantels modified
kernels when I had that problem. I now found in Hubert's Changelog:
-------------------------------------------------------------------
Sat May  5 15:17:10 CEST 2001 - mantel@suse.de
...
- fix max-sectors patch (fix horrible SCSI performance)
...

After compiling and booting the newer kernel,erformance seems fine now.

Bye
-- 
Uwe Bonnes                bon@elektron.ikp.physik.tu-darmstadt.de

Institut fuer Kernphysik  Schlossgartenstrasse 9  64289 Darmstadt
--------- Tel. 06151 162516 -------- Fax. 06151 164321 ----------
