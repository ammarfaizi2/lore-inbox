Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265902AbUFOT7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265902AbUFOT7H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 15:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265905AbUFOT7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 15:59:07 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:18561 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S265902AbUFOT7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 15:59:04 -0400
Date: Tue, 15 Jun 2004 19:59:03 +0000
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: Re: AT Keyboard (was: Helge Hafting vs. make menuconfig help)
Message-ID: <20040615195903.A7813@beton.cybernet.src>
References: <20040615140206.A6153@beton.cybernet.src> <20040615141039.GF20632@lug-owl.de> <20040615142040.B6241@beton.cybernet.src> <20040615144127.GG20632@lug-owl.de> <20040615172129.F6843@beton.cybernet.src> <20040615173210.GM20632@lug-owl.de> <20040615174651.A6965@beton.cybernet.src> <20040615183700.GA13866@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040615183700.GA13866@hh.idb.hist.no>; from helgehaf@aitel.hist.no on Tue, Jun 15, 2004 at 08:37:00PM +0200
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 4. From there, the key is propagated through tty and
>    console and ends up in your application.  This application
>    might be X, which passes the key onto some program using X.

I am insterested in the 4. itself.

What's the console? I get a feeling that it's where kernel writes it's debug
messages but sometimes else I get a feeling it's the text output of the
machine at all.

And what are the ttys? And does the key go first into console and then tty,
or the other way?

Cl<
