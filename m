Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbWF1T0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWF1T0h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 15:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWF1T0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 15:26:37 -0400
Received: from mail.charite.de ([160.45.207.131]:16264 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S1751024AbWF1T0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 15:26:36 -0400
Date: Wed, 28 Jun 2006 21:26:34 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: radeonfb: corrupted screen on bootup
Message-ID: <20060628192634.GJ28018@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200606282118.27750.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200606282118.27750.mb@bu3sch.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael Buesch <mb@bu3sch.de>:

> I have a weird error with my PowerBook G4, which
> has a radeon card. I am using radeonfb.
> After bootup, the screen sometimes looks like it is melting.
> I made a video to show you what is going on:
> http://bu3sch.de/misc/after_boot.avi  (6.1 MB)

The same SOMETIMES happens to me as well (Medion Laptop GD96400 with
an ATI card and the "radeon" driver from X.org), but I use the vesafb,
since the radeonfb won't recognize my card.

> But here comes the interresting part:
> If I switch back into the console, the screen becomes
> normal again and I can continue to work as usual.

Same here.
 
> I am suspecting some initialization routine bug.

Yep.

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
