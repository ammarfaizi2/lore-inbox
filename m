Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292933AbSBVTBa>; Fri, 22 Feb 2002 14:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292937AbSBVTBU>; Fri, 22 Feb 2002 14:01:20 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:48350 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S292933AbSBVTBH>;
	Fri, 22 Feb 2002 14:01:07 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15478.38253.321195.146088@napali.hpl.hp.com>
Date: Fri, 22 Feb 2002 11:01:01 -0800
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: davidm@hpl.hp.com, "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        Steffen Persvold <sp@scali.com>, linux-kernel@vger.kernel.org,
        jmerkey@timpanogas.org
Subject: Re: ioremap()/PCI sickness in 2.4.18-rc2 (FIXED ALMOST)
In-Reply-To: <3C769325.A8533881@mandrakesoft.com>
In-Reply-To: <20020220103320.A32211@vger.timpanogas.org>
	<20020220103539.B32211@vger.timpanogas.org>
	<3C73DC34.E83CCD35@mandrakesoft.com>
	<20020220.093034.112623671.davem@redhat.com>
	<20020220110004.A32431@vger.timpanogas.org>
	<20020220145449.A1102@vger.timpanogas.org>
	<20020220151053.A1198@vger.timpanogas.org>
	<3C7626A9.330A9249@scali.com>
	<20020222111756.A11081@vger.timpanogas.org>
	<15478.37161.767510.748999@napali.hpl.hp.com>
	<3C769325.A8533881@mandrakesoft.com>
X-Mailer: VM 7.00 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 22 Feb 2002 13:51:17 -0500, Jeff Garzik <jgarzik@mandrakesoft.com> said:

  Jeff> People would be surprised how much ground alpha axp broke in
  Jeff> userland, years ago, simply by being one of the first Linux
  Jeff> platforms where long != int

Yes.  And you don't want to know how many hours I personally spent on
this (along with several other folks).

	--david
