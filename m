Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWCHRhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWCHRhi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 12:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWCHRhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 12:37:38 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:12236 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751243AbWCHRhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 12:37:38 -0500
Date: Wed, 8 Mar 2006 17:37:11 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: Extra keycodes
Message-ID: <20060308173711.GA23254@srcf.ucam.org>
References: <20060223175328.GA25482@srcf.ucam.org> <200602242300.58815.dtor_core@ameritech.net> <20060226160730.GA5853@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060226160730.GA5853@srcf.ucam.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2006 at 04:07:30PM +0000, Matthew Garrett wrote:

> Patch included. We have code to pop up battery information in 
> gnome-power-manager in response to this key being pressed, and evdev is 
> the current interface for getting the keypress event.

Hi - any feedback on this?

Thanks,
-- 
Matthew Garrett | mjg59@srcf.ucam.org
