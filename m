Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbVKUXZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbVKUXZf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 18:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbVKUXZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 18:25:35 -0500
Received: from havoc.gtf.org ([69.61.125.42]:25829 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S964774AbVKUXZe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 18:25:34 -0500
Date: Mon, 21 Nov 2005 18:25:31 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Gustavo Guillermo =?iso-8859-1?Q?P=E9rez?= 
	<gustavo@compunauta.com>
Cc: USB development list <linux-usb-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: /dev/sr0 not ready, but working
Message-ID: <20051121232531.GA24565@havoc.gtf.org>
References: <200511211600.51338.gustavo@compunauta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200511211600.51338.gustavo@compunauta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 04:00:51PM -0600, Gustavo Guillermo Pérez wrote:
> When I use my external case as Firewire or USB 2.0 I got the error on the 
> kernel syslog:
> sr 0:0:0:0: Device not ready.
> last message repeated 187 times
> 
> Same using amdtp FireWire Driver and usb-storage driver.
> 
> but the drive keeps writing and the media finish and close as espected on the 
> 95% of times, the other 5% :(.

This happens on my S/ATAPI box too...	

	Jeff



