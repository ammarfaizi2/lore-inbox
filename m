Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbTJHHKg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 03:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbTJHHKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 03:10:36 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:49879 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261396AbTJHHKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 03:10:35 -0400
Subject: Re: 2.6.0.test6 - ppc - OHCI-1394 - bad: scheduling while atomic!
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: cliff white <cliffw@osdl.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031007154226.5bd55e43.cliffw@osdl.org>
References: <20031007154226.5bd55e43.cliffw@osdl.org>
Content-Type: text/plain
Message-Id: <1065596947.30835.72.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 08 Oct 2003 09:09:40 +0200
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-10-08 at 00:42, cliff white wrote:
> This has been happening to me since ~9/25/2003, with the
> linuxppc-2.5 bk tree on an iBook. Have not seen this error
> on my Via mini-ITX system, which runs mainline BK, and also
> has OHCI 1394.
> 
> Problem: OHCI 1394 puts this error in logs. Happens if
> compiled-in or built as module.

Please report this to the linux-1394 mailing list

Ben.


