Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264980AbTFCM1u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 08:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264981AbTFCM1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 08:27:50 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:50846 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264980AbTFCM1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 08:27:49 -0400
Date: Tue, 3 Jun 2003 13:45:01 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: Question about style when converting from K&R to ANSI C.
Message-ID: <20030603124501.GB13838@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	linux-kernel@vger.kernel.org
References: <1054446976.19557.23.camel@spc> <20030601132626.GA3012@work.bitmover.com> <1054519757.161606@palladium.transmeta.com> <20030603123256.GG1253@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030603123256.GG1253@admingilde.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03, 2003 at 02:32:56PM +0200, Martin Waitz wrote:

 > well, but it is nice to be able to grep for the declaration of a
 > function like
 > 
 > 	grep "^where_is_it" *.c
 > 
 > without showing all the uses of that function.

What's wrong with ctags for this?

		Dave

