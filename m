Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265290AbRFUXWN>; Thu, 21 Jun 2001 19:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265291AbRFUXWD>; Thu, 21 Jun 2001 19:22:03 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:10940 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S265290AbRFUXVw>;
	Thu, 21 Jun 2001 19:21:52 -0400
Message-ID: <3B32818B.CECD9505@mandrakesoft.com>
Date: Thu, 21 Jun 2001 19:21:47 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jhon H. Caicedo" <jhcaiced@osso.org.co>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AMD756VIPER PCI IRQ Routing Patch (Need Additional Tests)
In-Reply-To: <Pine.LNX.4.33.0106191306370.31330-200000@earth.cj.osso.org.co>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you use read_config_nybble and write_config_nybble, in your patch?
-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
