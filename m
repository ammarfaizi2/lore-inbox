Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275006AbTHFNFL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 09:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275007AbTHFNFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 09:05:11 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:61956 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S275006AbTHFNFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 09:05:08 -0400
Subject: Re: 2.5.70 lockup while write()ing to /dev/hda1
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: lode leroy <lode_leroy@hotmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Sea2-F12XkCBewSQRg600027013@hotmail.com>
References: <Sea2-F12XkCBewSQRg600027013@hotmail.com>
Content-Type: text/plain
Message-Id: <1060175105.558.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 06 Aug 2003 15:05:06 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-06 at 14:32, lode leroy wrote:
> I just want to report a problem I saw on linux 2.5.70:
> (since I have a workaround, I do not intend to debug this further)
> 
> the following program locks up the computer.
> sometimes this has happened after about 16MB,
> sometimes after about 64MB...

Don't you think 2.5.70 is a little bit obsolete now? ;-)
I recoomend you testing this on 2.6.0-test2-latest. Using the latest
available kernel will probably help mantainers to nail down any problem.

