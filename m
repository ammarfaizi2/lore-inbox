Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752147AbWAELLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbWAELLS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 06:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752150AbWAELLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 06:11:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54494 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752147AbWAELLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 06:11:15 -0500
Date: Thu, 5 Jan 2006 06:11:05 -0500
From: Dave Jones <davej@redhat.com>
To: Bernd Eckenfels <be-news06@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops pauser. / boot_delayer
Message-ID: <20060105111105.GK20809@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Bernd Eckenfels <be-news06@lina.inka.de>,
	linux-kernel@vger.kernel.org
References: <20060104221023.10249eb3.rdunlap@xenotime.net> <E1EuPZg-0008Kw-00@calista.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EuPZg-0008Kw-00@calista.inka.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 08:30:16AM +0100, Bernd Eckenfels wrote:
 > Randy.Dunlap <rdunlap@xenotime.net> wrote:
 > > This one delays each printk() during boot by a variable time
 > > (from kernel command line), while system_state == SYSTEM_BOOTING.
 > 
 > This sounds a bit like a aprils fool joke, what it is meant to do? You can
 > read the messages in the bootlog and use the scrollback keys, no?

could be handy for those 'I see a few messages that scroll, and the
box instantly reboots' bugs.  Quite rare, but they do happen.

		Dave
