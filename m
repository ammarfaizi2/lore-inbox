Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263921AbTDWAQZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 20:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263922AbTDWAQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 20:16:24 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:5091 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263921AbTDWAQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 20:16:24 -0400
Date: Wed, 23 Apr 2003 01:27:45 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [PATCH] 2.4.20 - intel AGP update
Message-ID: <20030423002745.GD26914@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
References: <20030422165041.A23064@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030422165041.A23064@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 22, 2003 at 04:50:41PM -0400, Bill Nottingham wrote:
 > AGP support for i852/i855/i865.
 > 
 > By David Dawes (<dawes@tungstengraphics.com>) in general; I
 > believe the only addition with respect to 2.5 is the i855PM
 > support added by me. Note that i855PM with integrated video
 > completely untested... my laptop has a built-in Radeon.

The 2.4 agpgart code is pretty much unmaintained.
When I get time (and once its stabilised) I'll do a backport of
the 2.5 stuff, but until then I've no objection to what goes in
there so feel free to bypass me..

I'd be interested in seeing the 855PM bits for 2.5 however..

		Dave
