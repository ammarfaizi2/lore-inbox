Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279663AbRJ0BOV>; Fri, 26 Oct 2001 21:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279665AbRJ0BOL>; Fri, 26 Oct 2001 21:14:11 -0400
Received: from mailsrv.rollanet.org ([192.55.114.7]:41242 "HELO
	mx.rollanet.org") by vger.kernel.org with SMTP id <S279663AbRJ0BOF>;
	Fri, 26 Oct 2001 21:14:05 -0400
Message-ID: <3BDA0A80.25B6554D@umr.edu>
Date: Fri, 26 Oct 2001 20:14:40 -0500
From: Nathan Neulinger <nneul@umr.edu>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Getting idle linux parport to look like idle Win32 parallel port
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a device hooked up to the parallel port that seems to behave
differently when hooked up to an idle windows parallel port compared to
an idle linux parallel port.

What is the difference between the two? And is there any way to convince
parport to get the port to look the same? My guess is that some pin is
being held high/low by parport and that isn't being done by windows, or
vice versa.

-- Nathan

------------------------------------------------------------
Nathan Neulinger                       EMail:  nneul@umr.edu
University of Missouri - Rolla         Phone: (573) 341-4841
Computing Services                       Fax: (573) 341-4216
