Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161046AbWBVRKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161046AbWBVRKx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 12:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWBVRKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 12:10:53 -0500
Received: from webmail.terra.es ([213.4.149.12]:50466 "EHLO
	csmtpout1.frontal.correo") by vger.kernel.org with ESMTP
	id S1751371AbWBVRKx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 12:10:53 -0500
Date: Wed, 22 Feb 2006 18:10:28 +0100 (added by postmaster@terra.es)
From: grundig <grundig@teleline.es>
To: David Zeuthen <david@fubar.dk>
Cc: torvalds@osdl.org, kay.sievers@suse.de, penberg@cs.Helsinki.FI,
       gregkh@suse.de, bunk@stusta.de, rml@novell.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: 2.6.16-rc4: known regressions
Message-Id: <20060222180614.39f2294b.grundig@teleline.es>
In-Reply-To: <1140625103.21517.18.camel@daxter.boston.redhat.com>
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org>
	<20060217231444.GM4422@stusta.de>
	<84144f020602190306o3149d51by82b8ccc6108af012@mail.gmail.com>
	<20060219145442.GA4971@stusta.de>
	<1140383653.11403.8.camel@localhost>
	<20060220010205.GB22738@suse.de>
	<1140562261.11278.6.camel@localhost>
	<20060221225718.GA12480@vrfy.org>
	<Pine.LNX.4.58.0602220905330.12374@sbz-30.cs.Helsinki.FI>
	<20060222152743.GA22281@vrfy.org>
	<Pine.LNX.4.64.0602220737170.30245@g5.osdl.org>
	<1140625103.21517.18.camel@daxter.boston.redhat.com>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.8.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 22 Feb 2006 11:18:22 -0500,
David Zeuthen <david@fubar.dk> escribió:


> But I realize these changes are important because it's progress and back
> in 2.6.0 things were horribly broken for at least desktop workloads [1].

As long as those changes don't come suddenly in the night, without a
transition period...

Check for Documentation/feature-removal-schedule.txt for some examples
of how to deprecate userland interfaces properly.
