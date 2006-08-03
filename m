Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbWHCNCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbWHCNCX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 09:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWHCNCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 09:02:22 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:32678 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932449AbWHCNCV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 09:02:21 -0400
Date: Thu, 3 Aug 2006 05:02:30 -0400
From: Mike Grundy <grundym@us.ibm.com>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: driver for thinkpad fingerprint sensor
Message-ID: <20060803090230.GA22104@localhost.localdomain>
References: <20060802203925.GA13899@elf.ucw.cz> <20060802214126.GA22928@atjola.homenet> <20060802230543.GA15561@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060802230543.GA15561@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 01:05:43AM +0200, Pavel Machek wrote:
> > I just gave it a try on my T43 (2668-WUM), works well if I swipe my
> > finger correctly, ends up in a loop otherwise (at least I guess it's bad
> > finger swiping).
I tried it on a T60p (2623-DDU). It did loop at the end of the enroll process,
but created the bir file and was able to do the verify. Probably the same
device as the T43.

Thanks
Mike

=========================================
Michael Grundy - grundym@us.ibm.com

If at first you don't succeed, call in an air strike.

