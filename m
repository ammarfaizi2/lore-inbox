Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272074AbTG2UjE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 16:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272075AbTG2UjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 16:39:04 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:25350 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S272074AbTG2Uhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 16:37:47 -0400
Date: Tue, 29 Jul 2003 22:37:45 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org, pgw99@doc.ic.ac.uk
Subject: Re: PATCH : LEDs - possibly the most pointless kernel subsystem ever
Message-ID: <20030729203745.GA2221@win.tue.nl>
References: <200307292038.h6TKcqlu000338@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307292038.h6TKcqlu000338@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 29, 2003 at 09:38:52PM +0100, John Bradford wrote:

> Ah, I just thought, for debugging purposes we could have LEDs for:
> 
> * BKL taken
> * Servicing interrupt
> * Kernel stack usage > 2K

Ever tried keyboard.c:register_leds() ?


