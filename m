Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbTHZAVn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 20:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbTHZAVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 20:21:43 -0400
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:38155 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262368AbTHZAVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 20:21:40 -0400
Subject: Re: linux-2.4.22 released
From: =?ISO-8859-1?Q?Ram=F3n?= Rey =?UTF-8?Q?Vicente?=
	 =?UTF-8?Q?=F3=AE=A0=92?= <retes_simbad@yahoo.es>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030825222215.GX7038@fs.tum.de>
References: <200308251148.h7PBmU8B027700@hera.kernel.org>
	 <20030825132358.GC14108@merlin.emma.line.org>
	 <1061818535.1175.27.camel@debian> <20030825211307.GA3346@werewolf.able.es>
	 <20030825222215.GX7038@fs.tum.de>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1061857293.15168.3.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 26 Aug 2003 02:21:34 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El mar, 26-08-2003 a las 00:22, Adrian Bunk escribió:

> > > > What are the plans for 2.4.23? XFS merge perhaps <hint>?
> > > 
> > > ALSA? low latency and related stuff?
> > 
> > I think ALSA is interesting to ease the migration to 2.6.
> > Let people move from OSS to ALSA, and then switch from 2.4 to 2.6...
> 
> Where's the problem with letting people switch from 2.4 to 2.6 and later
> from OSS to ALSA?
> 
> Since OSS is still present in 2.6 I don't see any migration problems.

I think merging ALSA in 2.4 series bring some of the advantages of the
2.6 series to the stable kernel, just new drivers with improvements over
OSS... but I dont think that will help in the switching to 2.6.
-- 
Ramón Rey Vicente       <ramon dot rey at hispalinux dot es>
        jabber ID       <rreylinux at jabber dot org>
------------------------------------------------------------
gpg public key ID 0xBEBD71D5 # http://pgp.escomposlinux.org/

