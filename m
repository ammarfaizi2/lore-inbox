Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315523AbSEHEuZ>; Wed, 8 May 2002 00:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315524AbSEHEuY>; Wed, 8 May 2002 00:50:24 -0400
Received: from vpl.usc.edu ([128.125.21.202]:14004 "EHLO vpl.usc.edu")
	by vger.kernel.org with ESMTP id <S315523AbSEHEuY>;
	Wed, 8 May 2002 00:50:24 -0400
Date: Tue, 7 May 2002 21:50:24 -0700
From: Joaquin Rapela <rapela@usc.edu>
To: linux-kernel@vger.kernel.org
Subject: es1371 sound problem
Message-ID: <20020507215024.B11180@plato.usc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I am having problems with a sound card. When I play a sound the machine becomes
frozen.

sndconfig tells reports an Ensoniq|ES1371 [AudioPCI-97]

After my machine recovers from the frozen stage I read the following in
/var/log/messages:

May  7 21:34:58 plato kernel: scsi : aborting command due to timeout : pid 0,
scsi0, channel 0, id 0, lun 0 Write (10) 00 01 05 aa 19 00 00 26 00 

I am running RH7.2 with kernel  2.4.7-10

Is this a problem of the kernel or of the sound card driver? How can I get
around this problem?

Any help will be greatly appreciated, Joaquin

