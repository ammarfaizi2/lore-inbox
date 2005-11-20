Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbVKTB7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbVKTB7d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 20:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbVKTB7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 20:59:33 -0500
Received: from smtpout3.uol.com.br ([200.221.4.194]:5581 "EHLO smtp.uol.com.br")
	by vger.kernel.org with ESMTP id S1751142AbVKTB7c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 20:59:32 -0500
Date: Sat, 19 Nov 2005 23:59:25 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: Does Linux support powering down SATA drives?
Message-ID: <20051120015924.GE20828@ime.usp.br>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
References: <437F63C1.6010507@perkel.com> <1132426887.19692.11.camel@localhost.localdomain> <200511191900.12165.s0348365@sms.ed.ac.uk> <1132431907.19692.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1132431907.19692.15.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 19 2005, Alan Cox wrote:
> It may spin a drive down but the power consumption of 23 hours a day
> of "spun down" is significant, probably more than the hour it is
> powered up.

Of course, so obvious now that you point it out.


Thanks, Rogério Brito.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
