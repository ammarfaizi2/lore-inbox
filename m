Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264142AbTKJWo3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 17:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264143AbTKJWo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 17:44:29 -0500
Received: from h24-76-142-122.wp.shawcable.net ([24.76.142.122]:64005 "HELO
	signalmarketing.com") by vger.kernel.org with SMTP id S264142AbTKJWo2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 17:44:28 -0500
Date: Mon, 10 Nov 2003 16:44:21 -0600 (CST)
From: Derek Foreman <manmower@signalmarketing.com>
X-X-Sender: manmower@uberdeity
To: Bradley Chapman <kakadu_croc@yahoo.com>
cc: davide.rossetti@roma1.infn.it, linux-kernel@vger.kernel.org
Subject: Re: OT: why no file copy() libc/syscall ??
In-Reply-To: <20031110120949.86290.qmail@web40907.mail.yahoo.com>
Message-ID: <Pine.LNX.4.58.0311101636450.319@uberdeity>
References: <20031110120949.86290.qmail@web40907.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Nov 2003, Bradley Chapman wrote:

> Mr. Rossetti,
>
> It is horribly RTFM.
>
> man 2 sendfile is what you're after.

I'm afraid it's not horribly RTFM at all.

sendfile won't do what he needs in 2.6.x.
