Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162815AbWLBNlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162815AbWLBNlu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 08:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162821AbWLBNlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 08:41:49 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:51904 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1162815AbWLBNlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 08:41:49 -0500
Subject: Re: Kernel Oops in 2.6.19
From: Arjan van de Ven <arjan@infradead.org>
To: Trond Gribbestad Lund <grev-ond@c2i.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200612021413.14770.grev-ond@c2i.net>
References: <200612021413.14770.grev-ond@c2i.net>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 02 Dec 2006 14:41:46 +0100
Message-Id: <1165066906.3233.161.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Modules linked in: nvidia(P) snd_pcm_oss snd_mixer_oss
> CPU:    1
> EIP:    0060:[<c014dda9>]    Tainted: P      VLI


does this happen only Linux code in the kernel? (eg without binary
drivers)

Greetings,
   Arjan van de Ven

