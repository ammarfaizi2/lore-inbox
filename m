Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbVAaHce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbVAaHce (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 02:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261946AbVAaH3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 02:29:04 -0500
Received: from [66.35.79.110] ([66.35.79.110]:39297 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S261675AbVAaH1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 02:27:13 -0500
Date: Sun, 30 Jan 2005 23:27:08 -0800
From: Tim Hockin <thockin@hockin.org>
To: Emmanuel Fleury <fleury@cs.aau.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Watchdog] alim7101_wdt problem on 2.6.10
Message-ID: <20050131072708.GA17354@hockin.org>
References: <41FDDCA3.7090701@cs.aau.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FDDCA3.7090701@cs.aau.dk>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 08:22:11AM +0100, Emmanuel Fleury wrote:
> Jan 30 00:58:21 hermes vmunix: alim7101_wdt: ALi 1543 South-Bridge does
> not have the correct revision number (???1001?) - WDT
> not set
> 
> What did I do wrong ?

You used the wrong South Bridge revision.  Seriously, older revisions of
M7101 did not have a WDT.  You seem to have an older revision.  Sorry.

