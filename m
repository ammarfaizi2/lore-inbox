Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266041AbUALBs6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 20:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266042AbUALBs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 20:48:58 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:29108 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S266041AbUALBs5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 20:48:57 -0500
Date: Sun, 11 Jan 2004 17:48:40 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH 2.4] i2c cleanups, third wave
Message-ID: <20040112014840.GE17845@matchmail.com>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
	LM Sensors <sensors@Stimpy.netroedge.com>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <20040111144214.7a6a4e59.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040111144214.7a6a4e59.khali@linux-fr.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 11, 2004 at 02:42:14PM +0100, Jean Delvare wrote:
> I will be sending 8 patches to you, based on linux-2.4.25-pre4. They
> contain cleanups for the i2c subsystem code, ported from LM Sensors' i2c
> CVS repository [1]. Since that repository was also the base of the i2c
> subsystem as is now in linux 2.6, one might also consider these patches
> as backports from linux 2.6.

How about some patches to add some more sensors to the 2.4 kernel, like the
ones already in 2.6?
