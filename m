Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWC1EUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWC1EUv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 23:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWC1EUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 23:20:51 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:10411 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751143AbWC1EUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 23:20:51 -0500
Subject: Re: OOM kills if swappiness set to 0, swap storms otherwise
From: Lee Revell <rlrevell@joe-job.com>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200603272312.18252.kernel-stuff@comcast.net>
References: <1143510828.1792.353.camel@mindpipe>
	 <20060327195905.7f666cb5.akpm@osdl.org>
	 <200603272312.18252.kernel-stuff@comcast.net>
Content-Type: text/plain
Date: Mon, 27 Mar 2006 23:20:46 -0500
Message-Id: <1143519647.11792.32.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-27 at 23:12 -0500, Parag Warudkar wrote:
> Lee - Perhaps you are running fat 64 bit code?

Nope, 32 bit system.  I think the problem is just a boring old memory
leak.

Lee

