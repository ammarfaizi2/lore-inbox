Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262149AbVC2CGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbVC2CGT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 21:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbVC2CGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 21:06:18 -0500
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:56021 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262149AbVC2CGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 21:06:15 -0500
Date: Mon, 28 Mar 2005 18:06:08 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Chris Wright <chrisw@osdl.org>
Cc: Coywolf Qi Hunt <coywolf@gmail.com>, Ali Akcaagac <aliakc@web.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel OOOPS in 2.6.11.6
Message-ID: <20050329020608.GA4675@taniwha.stupidest.org>
References: <1112008141.17962.1.camel@localhost> <20050328224430.GO28536@shell0.pdx.osdl.net> <2cd57c9005032814572b7e9bac@mail.gmail.com> <20050328230416.GP30522@shell0.pdx.osdl.net> <2cd57c9005032816126557d064@mail.gmail.com> <20050329002415.GV30522@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050329002415.GV30522@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 04:24:15PM -0800, Chris Wright wrote:

> Imperfect stack trace decoding.

Is this with CONFIG_4K_STACKS?  does it happen w/o it?
