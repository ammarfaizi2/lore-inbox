Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbTIOQPh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 12:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbTIOQPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 12:15:37 -0400
Received: from postman4.arcor-online.net ([151.189.0.189]:32699 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S261489AbTIOQPg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 12:15:36 -0400
Date: Mon, 15 Sep 2003 18:11:57 +0200
From: Juergen Quade <quade@hsnr.de>
To: carbonated beverage <ramune@net-ronin.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make pdfdocs problem
Message-ID: <20030915161157.GA18795@hsnr.de>
References: <20030915105729.GA8576@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20030915105729.GA8576@net-ronin.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 15, 2003 at 03:57:29AM -0700, carbonated beverage wrote:
> Hi all,
> ...
> LaTeX Font Warning: Font shape `[LOTS of \'s]\\\OT1/cmr/m/n' @undefined
> (Font)              using `\[LOTS of \s']\OT1/cmr/m/n' instead on input line 2.
> [snip]
> ! TeX capacity exceeded, sorry [save size=5000].

Try to increase the capacities. You just need to
edit the file
	/etc/texmf/texmf.cnf

	Juergen.
