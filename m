Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271100AbTGPUDA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 16:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271105AbTGPUC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 16:02:59 -0400
Received: from AMarseille-201-1-6-168.w80-11.abo.wanadoo.fr ([80.11.137.168]:9255
	"EHLO gaston") by vger.kernel.org with ESMTP id S271100AbTGPUC5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 16:02:57 -0400
Subject: Re: [PATCH] radeonfb 0.1.9 against 2.4.21pre2 (fwd)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ajoshi@kernel.crashing.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10307161258230.21751-100000@gate.crashing.org>
References: <Pine.LNX.4.10.10307161258230.21751-100000@gate.crashing.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1058386621.515.105.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 16 Jul 2003 22:17:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-16 at 20:10, ajoshi@kernel.crashing.org wrote:
> Many of these have already been addressed in 0.1.9, though I added the
> usage of the native clock, assertion for it, the dvi blanking, and the
> nolcd passthrough.  For things like the updated PM code, a patch would be
> helpful.

Ok, I don't know what's up here, maybe you send the wrong patch
to Marcelo or whatever, but what I have here labelled 0.1.9 doesn't
contain these. Native clock for LCD is definitely not here, DVI
blanking neither, though nolcd passthrough is there.

Ben.

