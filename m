Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266199AbUGON2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266199AbUGON2f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 09:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266200AbUGON2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 09:28:35 -0400
Received: from mail.tpgi.com.au ([203.12.160.61]:53159 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S266199AbUGON2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 09:28:34 -0400
Subject: Re: swsuspend not working
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: =?ISO-8859-1?Q?=C9ric?= Brunet <Eric.Brunet@lps.ens.fr>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040715132348.GA9939@lps.ens.fr>
References: <20040715121042.GB9873@lps.ens.fr>
	 <20040715121825.GC22260@elf.ucw.cz>  <20040715132348.GA9939@lps.ens.fr>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1089897699.3514.33.camel@nigel-laptop.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 15 Jul 2004 23:21:39 +1000
Content-Transfer-Encoding: 8bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-07-15 at 23:23, Éric Brunet wrote:
> On Thu, Jul 15, 2004 at 02:18:25PM +0200, Pavel Machek wrote:
> > You are not really using swsusp. You are using pmdisk. Fix your
> > kernel config.
> 
> Oh, I am confused; I believed that /proc/acpi/sleep was for swsuspend and
> /sys/power/state for pmdisk. Well, things are changing I guess.

Yes. Pavel and Patrick are working toward a Vulcan mind meld, I believe
:>

Nigel

