Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269750AbTGOVs7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 17:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269752AbTGOVs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 17:48:59 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:26117 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S269750AbTGOVs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 17:48:56 -0400
Subject: Re: IDE performance problems on 2.6.0-pre1
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: derek@signalmarketing.com
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.56.0307151617430.2932@uberdeity.signalmarketing.com>
References: <Pine.LNX.4.56.0307151617430.2932@uberdeity.signalmarketing.com>
Content-Type: text/plain
Message-Id: <1058306624.584.5.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 16 Jul 2003 00:03:45 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-15 at 23:49, derek@signalmarketing.com wrote:
> Hello,
> 
> My ide performance seems to have dropped noticably from 2.4.x to 
> 2.6.0-pre1...

What does "hdparm /dev/hde" tell us?

