Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbVK3Vjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbVK3Vjc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 16:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbVK3Vjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 16:39:32 -0500
Received: from mail.charite.de ([160.45.207.131]:46304 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S1750897AbVK3Vjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 16:39:31 -0500
Date: Wed, 30 Nov 2005 22:39:29 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: Linux kernel Mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Merely a warning to my fellow Nvidia travellers running 2.6.15-rc3
Message-ID: <20051130213928.GD16193@charite.de>
Mail-Followup-To: Linux kernel Mailing list <linux-kernel@vger.kernel.org>
References: <438E0187.2060107@telusplanet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <438E0187.2060107@telusplanet.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Bob Gill <gillb4@telusplanet.net>:
> This error message is merely a warning to my fellow Nvidia travellers.  
> Posts have already been sent to people who have the source code to fix 
> this, and this message is merely information for Nvidia users.  If you 
> are an Nvidia user trying to use 2.6.15-rc3 with the 7667 driver, beware 
> that the following can occur:

Indeed. This happens when I switch back from X11 to the fb console.
The nv driver has no such issues and works happily with rc3.
 
> .............as a result, its best to stick with with 2.6.15-rc2-git5 
> till a new driver comes out.

Yep, best bet.

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
