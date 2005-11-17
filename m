Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964861AbVKQUuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbVKQUuU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 15:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbVKQUuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 15:50:20 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:3801 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964858AbVKQUuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 15:50:19 -0500
Subject: software mixing [was Re: [linux-pm] [RFC] userland swsusp]
From: Lee Revell <rlrevell@joe-job.com>
To: Olivier Galibert <galibert@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
In-Reply-To: <20051117201204.GA32376@dspnet.fr.eu.org>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com>
	 <20051116164429.GA5630@kroah.com> <1132172445.25230.73.camel@localhost>
	 <20051116220500.GF12505@elf.ucw.cz>
	 <20051117170202.GB10402@dspnet.fr.eu.org>
	 <1132257432.4438.8.camel@mindpipe>
	 <20051117201204.GA32376@dspnet.fr.eu.org>
Content-Type: text/plain
Date: Thu, 17 Nov 2005 15:50:10 -0500
Message-Id: <1132260611.5959.11.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-17 at 21:12 +0100, Olivier Galibert wrote:
> 1- It doesn't work without an annoyingly complex, extremely badly
>    documented user configuration. To the point that it doesn't work in
>    either an out-of-the-box, updated Fedora Core 3 nor an
>    out-of-the-box gentoo. 

It's badly documented and complex because .asoundrc was never intended
to be user visible.  If the end user ever needs to edit their ALSA
config files for a standard setup there's a bug somewhere.

Anyway please provide the details of your sound hardware and ALSA driver
& alsa-lib version so we can determine why software mixing does not work
for you.

Lee

