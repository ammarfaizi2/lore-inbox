Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261482AbTC0XPK>; Thu, 27 Mar 2003 18:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261486AbTC0XPK>; Thu, 27 Mar 2003 18:15:10 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:24552 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S261482AbTC0XPJ>; Thu, 27 Mar 2003 18:15:09 -0500
Date: Thu, 27 Mar 2003 23:26:07 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Obsolete messages ...
Message-ID: <20030327232607.GC16251@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"David S. Miller" <davem@redhat.com>,
	Davide Libenzi <davidel@xmailserver.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.50.0303261857290.970-100000@blue1.dev.mcafeelabs.com> <1048774874.19677.0.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048774874.19677.0.camel@rth.ninka.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 06:21:14AM -0800, David S. Miller wrote:

 > > Any CONFIG_DROP_FREAKIN_OBSOLETE_MSGS (SO_BSDCOMPAT,bdflush,...) anywhere
 > > soon in 2.5.67 ? :)
 > 
 > If you fix the apps, the messages go away.  In fact, you want to know
 > that you have unfixed apps on your box when you run these kernels so
 > I'd say the messages should stay even well into early 2.6.x

If folks want to mail me reports of any app (and version, even distro
info) that reports these sorts of messages, I'll add them to the doc at 
http://www.codemonkey.org.uk/post-halloween-2.5.txt

		Dave

