Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbUAEQgO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 11:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264484AbUAEQgN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 11:36:13 -0500
Received: from ns.suse.de ([195.135.220.2]:44417 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263205AbUAEQgL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 11:36:11 -0500
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udev and devfs - The final word
References: <20040103040013.A3100@pclin040.win.tue.nl>
	<Pine.LNX.4.58.0401041847370.2162@home.osdl.org>
	<Pine.LNX.4.58.0401041903290.6089@dlang.diginsite.com>
	<200401042148.24742.rob@landley.net>
	<20040105151303.GA30849@mark.mielke.cc>
From: Andreas Schwab <schwab@suse.de>
X-Yow: My FAVORITE group is "QUESTION MARK & THE MYSTERIANS"...
Date: Mon, 05 Jan 2004 17:36:09 +0100
In-Reply-To: <20040105151303.GA30849@mark.mielke.cc> (Mark Mielke's message
 of "Mon, 5 Jan 2004 10:13:03 -0500")
Message-ID: <jey8smmjye.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke <mark@mark.mielke.cc> writes:

> There are a few cases that we might be forced to maintain regular
> numbers: mkfifo() creates a named pipe, and bind() creates a named
> socket.

Neither fifos nor sockets are devices.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
