Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWFYLx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWFYLx7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 07:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWFYLx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 07:53:58 -0400
Received: from mail.charite.de ([160.45.207.131]:9453 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S932409AbWFYLx6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 07:53:58 -0400
Date: Sun, 25 Jun 2006 13:53:55 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with 2.6.17-mm2
Message-ID: <20060625115355.GP27143@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060625103523.GY27143@charite.de> <20060625034913.315755ae.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060625034913.315755ae.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@osdl.org>:

> > 2) A problem with the powernow_k8 driver, which makes the kernel puke upon modprobe (at the end of my dmes output).
> 
> yup, I uploaded the below for for that into the hot-fixes directory.

Yes, the hotfix fixes this.

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
