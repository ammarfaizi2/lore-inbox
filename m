Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbUDZIbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbUDZIbo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 04:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbUDZIbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 04:31:44 -0400
Received: from levante.wiggy.net ([195.85.225.139]:53453 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S261351AbUDZIbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 04:31:43 -0400
Date: Mon, 26 Apr 2004 10:31:42 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Questions : disk partition re-reading
Message-ID: <20040426083142.GA26429@wiggy.net>
Mail-Followup-To: Andries Brouwer <aebr@win.tue.nl>,
	linux-kernel@vger.kernel.org
References: <4082819E.10106@free.fr> <20040420074650.GA3040@pclin040.win.tue.nl> <20040420143634.GA12132@bitwizard.nl> <20040425221528.GB3040@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040425221528.GB3040@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Andries Brouwer wrote:
> The answer is always the same: it exists and is called partx.

Is partx ready for prime time yet? The util-linux sources do not compile
or install it by default and the only comment in the HISTORY file is
'code to play with, not to use'.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.

