Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263234AbTESTmB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 15:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbTESTmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 15:42:01 -0400
Received: from mcomail02.maxtor.com ([134.6.76.16]:53009 "EHLO
	mcomail02.maxtor.com") by vger.kernel.org with ESMTP
	id S263234AbTESTmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 15:42:00 -0400
Message-ID: <785F348679A4D5119A0C009027DE33C102E0D3AA@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@maxtor.com>
To: "'azarah@gentoo.org'" <azarah@gentoo.org>,
       Arjan van de Ven <arjanv@redhat.com>
Cc: David Ford <david+cert@blue-labs.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       KML <linux-kernel@vger.kernel.org>
Subject: RE: Recent changes to sysctl.h breaks glibc
Date: Mon, 19 May 2003 13:54:34 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Monday, May 19, 2003 1:44 PM, Martin Schlemmer wrote:
> I think on the one hand the question is also ... how far
> will a developer of one distro go to help another.  I
> cannot say that I have had much success in the past to
> get a response from one of the 'big guys' to help me/us
> (the 'small guys') =)

AFAIK, it doesn't matter if a distro helps another or not.  As per Arjan van
de Ven's comment, I would think any code they release in terms of header
files based on original GPL source is itself GPL, and therefore
includable/usable/modifyable/redistributable by any distro.

Red Hat (or insert other large distro vendor here) might not want to
explicitly "help" their little competitors, but they have appeared to solve
this problem (according to other posts) and there's no reason you can't base
your own work off of that...

--eric


