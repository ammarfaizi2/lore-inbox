Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261295AbTAMOg5>; Mon, 13 Jan 2003 09:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261330AbTAMOg4>; Mon, 13 Jan 2003 09:36:56 -0500
Received: from hoemail2.lucent.com ([192.11.226.163]:1989 "EHLO
	hoemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id <S261295AbTAMOg4>; Mon, 13 Jan 2003 09:36:56 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15906.53517.125207.242140@gargle.gargle.HOWL>
Date: Mon, 13 Jan 2003 09:45:33 -0500
From: "John Stoffel" <stoffel@lucent.com>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-pre3-ac3
In-Reply-To: <20030111090525.GD19960@charite.de>
References: <20030110202250.GA1405@brodo.de>
	<200301110137.h0B1bQV21956@devserv.devel.redhat.com>
	<20030111090525.GD19960@charite.de>
X-Mailer: VM 7.07 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just a quick me-too on 2.4.21-pre3-ac3, it's better than -ac2, which
seems to have randomly locked up at times and then I ended up losing a
bunch of binaries in /usr/bin/... for some reason.  Plus some /dev
entries as well.

It's amazing what breaks in X when random parts like /dev/tty7 and
stuff in /usr/bin are gone, and it's *very* un-enlightening what the
problem is.

John
