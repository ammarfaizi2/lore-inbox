Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbTKIRoG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 12:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbTKIRoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 12:44:06 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:7323 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262730AbTKIRoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 12:44:02 -0500
Date: Sun, 9 Nov 2003 17:39:36 +0000
From: Dave Jones <davej@redhat.com>
To: Robert Love <rml@tech9.net>
Cc: Tomasz Torcz <zdzichu@irc.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bert hubert <ahu@ds9a.nl>, Maciej Zenczykowski <maze@cela.pl>
Subject: Re: Syscalls being obsoleted???
Message-ID: <20031109173936.GE10144@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Robert Love <rml@tech9.net>, Tomasz Torcz <zdzichu@irc.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	bert hubert <ahu@ds9a.nl>, Maciej Zenczykowski <maze@cela.pl>
References: <Pine.LNX.4.44.0311071236110.26063-100000@gaia.cela.pl> <20031108114909.GA21937@outpost.ds9a.nl> <20031108192112.GA2144@irc.pl> <1068337499.27320.208.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1068337499.27320.208.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 08, 2003 at 07:24:59PM -0500, Robert Love wrote:
 > > I think that he meant this phrase in post-halloween-2.5.txt:
 > > #v+
 > > - Calling syscalls by numeric values is deprecated, and will go away
 > >   in the next development series.
 > > #v-
 > > 
 > > What is new way of calling syscalls?
 > 
 > I think Dave means "sysctl" here, not syscalls.

I did.

 > Dave, this probably needs changing in the post-halloween-2.5.txt
 > document.

I did.
Yet again, that amusing case appears where a thinko has been there
for months without anyone noticing, and once I've fixed it everyone
and his dog spots it 8-)

		Dave

