Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbUBIIOG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 03:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbUBIIOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 03:14:06 -0500
Received: from sweetums.bluetronic.net ([24.199.150.42]:31672 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S263185AbUBIIOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 03:14:04 -0500
Date: Mon, 9 Feb 2004 03:12:11 -0500 (EST)
From: Ricky Beam <jfbeam@bluetronic.net>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: Does anyone still care about BSD ptys?
In-Reply-To: <402736D6.4000502@zytor.com>
Message-ID: <Pine.GSO.4.33.0402090309000.28488-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Feb 2004, H. Peter Anvin wrote:
>Right, this is basically for 2.6/2.7 depending on if there are any
>stragglers who still use these things...

nettty (whatever you may find it named) uses the BSD pty interface.  I don't
know how much work it would be to get it to use /dev/pts.  I've not used it
for many years, so I cannot say anyone would care if it stopped working.

The code is at least 7 years old (originally written by Livingston.)

--Ricky


