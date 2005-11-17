Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbVKQUry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbVKQUry (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 15:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbVKQUry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 15:47:54 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:26328 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964854AbVKQUry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 15:47:54 -0500
Subject: Re: [linux-pm] [RFC] userland swsusp
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
Date: Thu, 17 Nov 2005 15:47:46 -0500
Message-Id: <1132260466.5959.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-17 at 21:12 +0100, Olivier Galibert wrote:
> You call that great?  Multiple audio streams is such a basic feature
> it should work, period.  No if, no buts, and no obligatory library.
> Which doesn't preclude having it in userspace, mind you.  But it
> should never have been the _application_'s responsability.

Um, it really belongs in HARDWARE like it used to be, but vendors are
way too cheap for that now.  Keep in mind the whole mixing discussion
amounts to "how do we deal with these broken devices".

Lee


