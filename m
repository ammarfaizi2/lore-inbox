Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272910AbTHKWAS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 18:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273403AbTHKWAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 18:00:18 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:29446 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S272910AbTHKWAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 18:00:16 -0400
Date: Tue, 12 Aug 2003 00:00:12 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Harm Verhagen <h.verhagen@chello.nl>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Apacer SM/CF combo reader driver
Message-ID: <20030812000012.A1353@pclin040.win.tue.nl>
References: <1060637573.18663.10.camel@i141046.upc-i.chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1060637573.18663.10.camel@i141046.upc-i.chello.nl>; from h.verhagen@chello.nl on Mon, Aug 11, 2003 at 11:32:54PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 11:32:54PM +0200, Harm Verhagen wrote:

> > Apacer SM/CF combo reader, USB 07c4:a109. 

> I needed to compile the kernel (RedHat 2.4.20-19.9) with the "Probe all
> LUNs on each device" option enabled (CONFIG_SCSI_MULTI_LUN) in order to
> access the SM on my apacer combo reader (0x0d7d:0x0240).

That is an entirely different animal. Unrelated.

