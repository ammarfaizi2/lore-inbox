Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932480AbWACStV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbWACStV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 13:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWACStV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 13:49:21 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:57263 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932480AbWACStV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 13:49:21 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] the scheduled removal of obsolete OSS drivers
Date: Wed, 04 Jan 2006 05:49:16 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <4jglr15vlmhqh9121ul3eavck4rmaaavl2@4ax.com>
References: <20060103114900.GA3831@stusta.de>
In-Reply-To: <20060103114900.GA3831@stusta.de>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jan 2006 12:49:00 +0100, Adrian Bunk <bunk@stusta.de> wrote:

>This patch contains the scheduled removal of obsolete OSS drivers with 
>ALSA replacements.

G'day Adrian, 

patch applies with one small offset after Greg's no devfs patch series 
to 2.6.15 ;-)

So I'm running 2.6.15nodevoss on 'sempro' box now.
                     ^^^^^^^^--> no devfs, no oss

Didn't feel a thing.

Grant.
