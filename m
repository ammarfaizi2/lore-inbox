Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270751AbTGUWFv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 18:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270752AbTGUWFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 18:05:51 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:18190 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S270751AbTGUWFs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 18:05:48 -0400
Date: Tue, 22 Jul 2003 00:20:49 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test1: "make help" is not complete
Message-ID: <20030721222049.GA2602@mars.ravnborg.org>
Mail-Followup-To: "Robert P. J. Day" <rpjday@mindspring.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53.0307210827200.5101@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307210827200.5101@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 21, 2003 at 08:29:37AM -0400, Robert P. J. Day wrote:
> 
>   just an observation -- "make help" doesn't list all possible
> make options.  minimally, "make randconfig" is not listed there,
> although i'm not surprised that this feature is not prominently
> advertised. :-)
"make help" is not for the advanced user.
I deliberately did not include the more exotic targets - and you may
argue that there is already too many targets listed.

I see no reason to include more targets in "make help".

	Sam
