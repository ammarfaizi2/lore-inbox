Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTLJA1k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 19:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbTLJA1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 19:27:40 -0500
Received: from 217-124-44-246.dialup.nuria.telefonica-data.net ([217.124.44.246]:7050
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S262115AbTLJA1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 19:27:39 -0500
Date: Wed, 10 Dec 2003 01:27:37 +0100
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Device-mapper submission for 2.4
Message-ID: <20031210002737.GA27208@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0312092047450.1289-100000@logos.cnet> <Pine.LNX.4.56.0312092329280.30298@fogarty.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0312092329280.30298@fogarty.jakma.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 09 December 2003, at 23:46:13 +0000,
Paul Jakma wrote:

> There are people who store their data in LVM, we need compatibility,
> and ideally we'd like to be able to migrate in small steps.
> 
Install "module-init-tools", install "LVM2" (that can drive both LVM1
and DM Logical Volumes), compile a 2.6.x Linux kernel, reboot and you
should be done.

As far as I remember, migration is just that easy, and you can always go
back to plain 2.4.x while you don't update LVM metadata to newer version 2.

Greetings.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0-test10-mm1)
