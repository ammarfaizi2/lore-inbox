Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264962AbTANSqC>; Tue, 14 Jan 2003 13:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264963AbTANSqC>; Tue, 14 Jan 2003 13:46:02 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:12455 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S264962AbTANSqC>; Tue, 14 Jan 2003 13:46:02 -0500
From: Richard Stallman <rms@gnu.org>
To: mark@mark.mielke.cc
CC: root@chaos.analogic.com, pollard@admin.navo.hpc.mil,
       R.E.Wolff@BitWizard.nl, jalvo@mbay.net, linux-kernel@vger.kernel.org
In-reply-to: <20030113175107.GA7770@mark.mielke.cc> (message from Mark Mielke
	on Mon, 13 Jan 2003 12:51:07 -0500)
Subject: Re: Nvidia and its choice to read the GPL "differently"
Reply-to: rms@gnu.org
References: <200301131109.48727.pollard@admin.navo.hpc.mil> <Pine.LNX.3.95.1030113121925.26995A-200000@chaos.analogic.com> <20030113175107.GA7770@mark.mielke.cc>
Message-Id: <E18YWD6-000450-00@fencepost.gnu.org>
Date: Tue, 14 Jan 2003 13:54:52 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Heck, even glibc was not used by most distributions before a few years ago.

Most or all GNU/Linux distributions in 1993 used a modified version of
GNU libc.  They called it "Linux libc", so you might not have realized
it was actually GNU libc modified.

We wanted GNU libc to work unmodified in GNU/Linux systems, so we paid
the original author of GNU libc to do the necessary work.  The result
was GNU libc version 2.

