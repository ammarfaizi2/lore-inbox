Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262334AbUKQOqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262334AbUKQOqF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 09:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbUKQOqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 09:46:04 -0500
Received: from mail.convergence.de ([212.227.36.84]:16869 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S262336AbUKQOp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 09:45:58 -0500
Date: Wed, 17 Nov 2004 15:49:51 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-dvb-maintainer] [2.6 patch] remove unused dvb-core/Makefile.lib
Message-ID: <20041117144951.GC6084@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Adrian Bunk <bunk@stusta.de>, linux-dvb-maintainer@linuxtv.org,
	linux-kernel@vger.kernel.org
References: <20041117120352.GN4943@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041117120352.GN4943@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 01:03:52PM +0100, Adrian Bunk wrote:
> The patch below removes the completely unused 
> drivers/media/dvb/dvb-core/Makefile.lib (this file seems to be a 
> leftover from the times when this wasn't handled with select).

This file had already been removed from linuxtv.org CVS.

Thanks,
Johannes
