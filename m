Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbTLWUhs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 15:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbTLWUhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 15:37:47 -0500
Received: from dialin-145-254-136-101.arcor-ip.net ([145.254.136.101]:25472
	"EHLO pttpc1.ups-tlse.fr") by vger.kernel.org with ESMTP
	id S261928AbTLWUhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 15:37:46 -0500
From: Klaus Frahm <frahm@irsamc.ups-tlse.fr>
Message-Id: <200312232037.hBNKbLT03797@pttpc1.ups-tlse.fr>
Subject: Re: Bug/Problem when using 2 USB memory sticks in 2.4.23 and 2.4.24-pre2
To: mdharm-kernel@one-eyed-alien.net (Matthew Dharm)
Date: Tue, 23 Dec 2003 21:37:21 +0100 (CET)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031223200412.GA13048@one-eyed-alien.net> from "Matthew Dharm" at Dec 23, 2003 12:04:12 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Use 'eject /dev/sda' to force the kernel to re-scan the new media when you
> change sticks.
> 
> The problem is that the device does not give a media-change indication, as
> it should.
> 
> Matt
> 
> On Tue, Dec 23, 2003 at 08:52:11PM +0100, Klaus Frahm wrote:
> > Bug/Problem when using 2 USB memory sticks in 2.4.23 and 2.4.24-pre2


Thanks for the information. This works indeed. 

Klaus.

