Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265883AbUAKOdo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 09:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265887AbUAKOdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 09:33:44 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:39696 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S265883AbUAKOdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 09:33:42 -0500
Date: Sun, 11 Jan 2004 15:33:38 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: "Pablo E. Limon Garcia Viesca" <plimon@intercable.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GIVEUP [bootup kernel panic 2.6.x] no root partition detected?
Message-ID: <20040111143338.GA1923@win.tue.nl>
References: <40005E9C.3030309@intercable.net> <4000D463.3040707@intercable.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4000D463.3040707@intercable.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 10, 2004 at 10:43:15PM -0600, Pablo E. Limon Garcia Viesca wrote:

> Hello again, after two days of trying to solve my problem I give up now.

Hmm - no information at all?

Let me search the archives.

>> Partition check:
>> hda: [DM6:DD0] [remap +63] [2480/255/63] hda1 hda2 <hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12>

Aha. Boot, and give boot parameter "hda=remap63".

Andries

