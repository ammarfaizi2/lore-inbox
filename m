Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264723AbTFAUbA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 16:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264725AbTFAUbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 16:31:00 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:4359 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S264723AbTFAUbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 16:31:00 -0400
Date: Sun, 1 Jun 2003 22:44:22 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Stig Brautaset <stig@brautaset.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70: scripts/Makefile.build fix
Message-ID: <20030601204422.GA1021@mars.ravnborg.org>
Mail-Followup-To: Stig Brautaset <stig@brautaset.org>,
	linux-kernel@vger.kernel.org
References: <20030601184335.GA31452@brautaset.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030601184335.GA31452@brautaset.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 01, 2003 at 07:43:35PM +0100, Stig Brautaset wrote:
> Hi, 
> 
> This patch seems to fix `make V=0' for me.

Thanks for the patch.
I do not see the broken behaviour here. Can you provide me with information
about your system:
Make version, shell, architecture, distribution.

I got one report in private mail about make V=0 was broken, and would like
to find out what is causing the problem.

	Sam
