Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265573AbRFVX2H>; Fri, 22 Jun 2001 19:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265574AbRFVX14>; Fri, 22 Jun 2001 19:27:56 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:30419 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S265573AbRFVX1m>;
	Fri, 22 Jun 2001 19:27:42 -0400
Message-ID: <3B33D467.ABAE9D84@mandrakesoft.com>
Date: Fri, 22 Jun 2001 19:27:35 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Eric Smith <eric@brouhaha.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2 yenta_socket problems on ThinkPad 240
In-Reply-To: <Pine.LNX.4.21.0106161111041.9713-100000@penguin.transmeta.com> <20010622231457.11642.qmail@brouhaha.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You should try 2.4.6-pre5, it already includes a patch for you :)

pci=assign-busses on the command line.

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
