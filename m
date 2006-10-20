Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992551AbWJTSAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992551AbWJTSAI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 14:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992554AbWJTSAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 14:00:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22711 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S2992551AbWJTSAE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 14:00:04 -0400
Date: Fri, 20 Oct 2006 13:59:58 -0400
From: Alan Cox <alan@redhat.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc2-mm2] fix tty_ioctl powerpc build
Message-ID: <20061020175958.GD12290@devserv.devel.redhat.com>
References: <20061020015641.b4ed72e5.akpm@osdl.org> <Pine.LNX.4.64.0610201626500.12392@blonde.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610201626500.12392@blonde.wat.veritas.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 04:34:03PM +0100, Hugh Dickins wrote:
> Fix tty_ioctl.c compilation errors and warnings on PowerPC, coming from
> the tty-switch-to-ktermios patches; and make its ktermios the same as
> its termios (as the comment says).
> 
> Signed-off-by: Hugh Dickins <hugh@veritas.com>

Acked-by: Alan Cox <alan@redhat.com>

