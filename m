Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbUK0WBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbUK0WBu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 17:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbUK0WBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 17:01:50 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:64468 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261345AbUK0WBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 17:01:48 -0500
Subject: Re: RivaFB and GeForce FX
From: Lee Revell <rlrevell@joe-job.com>
To: Oded Shimon <ods15@ods15.dyndns.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200411242347.07911.ods15@ods15.dyndns.org>
References: <200411242347.07911.ods15@ods15.dyndns.org>
Content-Type: text/plain
Date: Sat, 27 Nov 2004 17:01:46 -0500
Message-Id: <1101592907.15635.5.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-24 at 23:47 +0200, Oded Shimon wrote:
> I'm currently working on getting complete support for Geforce FX for RivaFB.

> The 
> only working reference I have for that though is the binary, closed source, 
> official Nvidia X module.
> 

> I would like some advice 
> about what actions I should take next in getting more complete support.

Are you asking "how do I reverse engineer a binary driver"?  One method
is to run it under an emulator, and capture the PCI bus traffic.  Then
there are tried and true methods like IDA Pro.

Lee


