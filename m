Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291780AbSBTLjE>; Wed, 20 Feb 2002 06:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291781AbSBTLiy>; Wed, 20 Feb 2002 06:38:54 -0500
Received: from [12.237.133.3] ([12.237.133.3]:16771 "EHLO ledzep.dyndns.org")
	by vger.kernel.org with ESMTP id <S291780AbSBTLik>;
	Wed, 20 Feb 2002 06:38:40 -0500
Message-ID: <3C738AA0.AC31A1BB@attbi.com>
Date: Wed, 20 Feb 2002 05:38:08 -0600
From: Jordan Breeding <ledzep37@attbi.com>
Organization: University of Texas at Dallas - Student
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.5-xfs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Adaptec dpt_i20.c broken in 2.5?
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I will most likely be purchasing a system soon which will make use of an
Adaptec Zero Channel raid card and so it will require the use of the
dpt_i2o Adaptec driver.  However, currently in 2.5.5 if you select
Adaptec i2o to be compiled it gives an error caused by this line:

#error Please convert me to Documentation/DMA-mapping.txt

Will this be fixed in a -pre version any time soon?  Thanks for any info
on the situation with this scsi driver.

Jordan
