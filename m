Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVADLXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVADLXh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 06:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbVADLXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 06:23:37 -0500
Received: from cmu-24-35-113-109.mivlmd.cablespeed.com ([24.35.113.109]:4085
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261161AbVADLXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 06:23:36 -0500
Date: Tue, 4 Jan 2005 06:23:22 -0500 (EST)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm1 [failure on AMD64]
In-Reply-To: <200501040029.15623.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.61.0501040613240.4992@localhost.localdomain>
References: <20050103011113.6f6c8f44.akpm@osdl.org> <20050103100725.GA17856@infradead.org>
 <200501030919.20670.jbarnes@engr.sgi.com> <200501040029.15623.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2005, Rafael J. Wysocki wrote:

> On a UP AMD64 it boots, but then it does not work appropriately (eg. at KDE
> startup the box hangs for a while and I get the message like "The process for
> the file protocol has terminated unexpectedly" and desktop icons are not
> displayed, and I get a "cpu overload" message from arts etc.).

I also tried it on an AMD64 system (3500+ on A8V Deluxe) and did not 
observe any anomalies, but I am using Gnome, not KDE.

I saw a message that latency tests were wanted, but I don't normally have 
a workload in which this can be observed.  Perhaps someone could provide a 
suggestion?  I did try some dvd-burning sessions.  Subjectively speaking, 
there didn't seem to be any improvement over 2.6.10, and it may have been 
a bit worse.
