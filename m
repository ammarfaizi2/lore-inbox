Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbTDUUyG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 16:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbTDUUyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 16:54:06 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58893 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262005AbTDUUyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 16:54:05 -0400
Date: Mon, 21 Apr 2003 14:05:56 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix CPU Names in Kconfig
In-Reply-To: <20030421205520.GA13940@averell>
Message-ID: <Pine.LNX.4.44.0304211405070.17938-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 Apr 2003, Andi Kleen wrote:
> 
> OldXeon for the P3 based Xeons is a bit confusing, but we cannot 
> fix the Intel marchitecture here.

That's wrong. The P4-based Xeons are just "Xeon". The PIII-based Xeons are 
"Pentium III Xeon".

		Linus

