Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbWFFLvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWFFLvD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 07:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWFFLvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 07:51:03 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:17106 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751282AbWFFLvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 07:51:01 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andi Kleen <ak@suse.de>
Subject: Re: AMD64: 64 bit kernel 32 bit userland - some pending questions
Date: Tue, 6 Jun 2006 13:51:08 +0200
User-Agent: KMail/1.9.3
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       linux-kernel@vger.kernel.org
References: <20060606093456.GL4552@cip.informatik.uni-erlangen.de> <p73lksazht5.fsf@verdi.suse.de>
In-Reply-To: <p73lksazht5.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606061351.08733.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 June 2006 12:42, Andi Kleen wrote:
> Thomas Glanzmann <sithglan@stud.uni-erlangen.de> writes:
> 
> > Hello everyone,
> > I would like to use an AMD64 Opteron System with a 64 bit Linux Kernel,
> > but a 32 bit userland (Debian Sarge). I have a few questions about this:
> 
> The main caveat is that iptables and ipsec need 64bit executables
> to be set up. The rest should work.

Recently I've had a problem running wine with a 16-bit windows application
on a 64-bit kernel.  I guess it's a wine's problem, then?

Greetings,
Rafael
