Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbUK0WP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbUK0WP0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 17:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbUK0WP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 17:15:26 -0500
Received: from mail.charite.de ([160.45.207.131]:28306 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S261349AbUK0WPT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 17:15:19 -0500
Date: Sat, 27 Nov 2004 23:15:18 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-ac12
Message-ID: <20041127221518.GX30987@charite.de>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1101480210.23210.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1101480210.23210.2.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox <alan@lxorguk.ukuu.org.uk>:
> This -ac is a little different. It's an experimental -ac to test the 
> accumulated patches it would be nice to have in -ac but which might break
> something and seemed too risky. As such please test it but in general wait
> for the next -ac before planning to update production systems.
> 
> Arjan van de Ven is now building RPMS of the kernel and those can be found
> in the RPM subdirectory and should be yum-able. Expect the RPMS to lag the
> diff a little as the RPM builds and tests do take time.
> 
> The it8212 still doesn't default to DMA on - that is on the TODO list. The
> HPT366 rework project is also not ready (its gone back to the drawing
> board for a few days if you are a volunteer and wondered what is up).
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/alan/linux-2.6/2.6.9/

It's not there yet...

-- 
Ralf Hildebrandt (i.A. des IT-Zentrum)          Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
