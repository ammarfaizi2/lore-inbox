Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbTKKIzh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 03:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264276AbTKKIzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 03:55:36 -0500
Received: from mail.enyo.de ([212.9.189.167]:44557 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S264275AbTKKIzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 03:55:33 -0500
Date: Tue, 11 Nov 2003 09:55:30 +0100
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 and cryptoloop
Message-ID: <20031111085530.GB11435@deneb.enyo.de>
References: <bop628$7km$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bop628$7km$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.5.4i
From: Florian Weimer <fw@deneb.enyo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bill davidsen wrote:

> I see that recent 2.4 has crypto. Is there a version of the tools which
> will do cryptoloop using the kernel as released? I tried the old 2.4
> version I had, and the latest version which works with 2.6, neither
> worked to do an losetup.

losetup from util-linux 2.12 should work.
