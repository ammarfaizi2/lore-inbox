Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbWB1TNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWB1TNz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 14:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWB1TNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 14:13:55 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:58569 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932429AbWB1TNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 14:13:55 -0500
Subject: Re: Line6 variax driver
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: grabner@icg.tu-graz.ac.at
In-Reply-To: <1141093470.3264.12.camel@mindpipe>
References: <1141093470.3264.12.camel@mindpipe>
Content-Type: text/plain
Date: Tue, 28 Feb 2006 14:13:48 -0500
Message-Id: <1141154029.5860.22.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-27 at 21:24 -0500, Lee Revell wrote:
> This is an excerpt from Markus's mail to alsa-devel.  We are trying to
> get his out of tree Line6 driver into the kernel.  The PCM and MIDI
> stuff goes in ALSA, but can someone recommend the most appropriate type
> of driver for the Variax component of his Line6 driver - basically just
> a /sys interface to the pickup settings on these guitars?

Never mind it looks like this can all go in userspace and the ALSA
driver

