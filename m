Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267520AbTGHSgD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 14:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267521AbTGHSgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 14:36:03 -0400
Received: from h24-78-210-69.ss.shawcable.net ([24.78.210.69]:12 "HELO
	discworld.dyndns.org") by vger.kernel.org with SMTP id S267520AbTGHSf6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 14:35:58 -0400
Date: Tue, 8 Jul 2003 12:55:20 -0600
From: Charles Cazabon <linux@discworld.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Forking shell bombs
Message-ID: <20030708125520.B27956@discworld.dyndns.org>
References: <20030708184537.GJ1030@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030708184537.GJ1030@dbz.icequake.net>; from nemesis-lists@icequake.net on Tue, Jul 08, 2003 at 01:45:37PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Underwood <nemesis-lists@icequake.net> wrote:
> 
> [Fork bomb] and watch linux die. (2.4.21 stock)

That's what per-user process limits are for.  Doesn't matter if it's a
shellscript or something else; any system without limits set is vulnerable.

Charles
-- 
-----------------------------------------------------------------------
Charles Cazabon                            <linux@discworld.dyndns.org>
GPL'ed software available at:     http://www.qcc.ca/~charlesc/software/
-----------------------------------------------------------------------
