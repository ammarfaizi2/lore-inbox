Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263429AbUEYIA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUEYIA4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 04:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264799AbUEYIAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 04:00:55 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:56202 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S263429AbUEYIAy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 04:00:54 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 25 May 2004 09:40:28 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: drivers/media/video/ir-kbd-gpio.c compile error
Message-ID: <20040525074028.GB12204@bytesex.org>
References: <20040524145752.66376880.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040524145752.66376880.akpm@osdl.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> static IR_KEYTAB_TYPE ir_codes_avermedia[IR_KEYTAB_SIZE] = {
> 	[ 24 ] = KEY_RED,         // unmarked

This one should be 23.

  Gerd

-- 
Smoking Crack Organization
