Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262407AbUKKWkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbUKKWkO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 17:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbUKKWgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 17:36:55 -0500
Received: from mail.charite.de ([160.45.207.131]:49114 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S262378AbUKKWeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 17:34:24 -0500
Date: Thu, 11 Nov 2004 23:34:21 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: FB: vesafb garbled after using X11 with nv driver
Message-ID: <20041111223421.GF24338@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20041111215530.GB24338@charite.de> <200411112331.05405.christian.hesse@linuxob.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200411112331.05405.christian.hesse@linuxob.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christian Hesse <christian.hesse@linuxob.de>:

> I have a similar problem. With open source nv and vesafb the virtual terminal 
> looks like this if I switch back to the framebuffer:
> 
> http://linux.eworm.net/nv_offset.jpg

You're way better of than I am, since you can SEE something.
 
> As binary nvidia module works without this problem I support it's a problem of 
> nv...

Same here, the binary nvidia module doesn't give me that problem.
So it's nv, and probably OT for lkml. Sorry for the noise, guys.

-- 
Ralf Hildebrandt (i.A. des IT-Zentrum)          Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
