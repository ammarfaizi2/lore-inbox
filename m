Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263139AbRFGVBK>; Thu, 7 Jun 2001 17:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263141AbRFGVBA>; Thu, 7 Jun 2001 17:01:00 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:64179 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263139AbRFGVAy>;
	Thu, 7 Jun 2001 17:00:54 -0400
Message-ID: <3B1FEB7E.D06B10A2@mandrakesoft.com>
Date: Thu, 07 Jun 2001 17:00:46 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: VM suggestion...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While you guys are in there hacking, perhaps consider adding metrics
which allows you to tell exactly when certain cases and conditions are
hit.
	page_aged_while_sleeping_in_page_lauder++

Statistics like this are cheap to use in runtime and should provide
concrete information rather than guesses and estimations...

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
