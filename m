Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVA1JOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVA1JOi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 04:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVA1JOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 04:14:38 -0500
Received: from mail.charite.de ([160.45.207.131]:55685 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S261240AbVA1JOc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 04:14:32 -0500
Date: Fri, 28 Jan 2005 10:14:30 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Re:parport disabled?
Message-ID: <20050128091430.GA6769@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050127150306.GA29334@linux.ensimag.fr> <20050127213957.GE23534@charite.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050127213957.GE23534@charite.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>:

> > Try disabling acpi.
> 
> Didn't help. Same symptom

I was able to make it work by going to the BIOS and set the IO & IRQ there.

-- 
Ralf Hildebrandt (i.A. des IT-Zentrum)          Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
