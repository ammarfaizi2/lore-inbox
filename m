Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030579AbWJ3TiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030579AbWJ3TiG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 14:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161243AbWJ3TiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 14:38:06 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:47245 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1030580AbWJ3TiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 14:38:05 -0500
Date: Mon, 30 Oct 2006 15:36:02 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>,
       user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/11] UBD driver little cleanups for 2.6.19
Message-ID: <20061030203602.GA6122@ccure.user-mode-linux.org>
References: <20061029191723.12292.50164.stgit@americanbeauty.home.lan> <20061029120224.d25e3204.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061029120224.d25e3204.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2006 at 12:02:24PM -0800, Andrew Morton wrote:
> I'm not particularly fussed about UBD though - if you and Jeff particularly
> want this lot in 2.6.19 then the world won't end.

I'm fine with these - I have a stylistic quibble here and there, but
the changes are either no-ops or small bug fixes.

				Jeff

-- 
Work email - jdike at linux dot intel dot com
