Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbTFXSUB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 14:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263245AbTFXSUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 14:20:00 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:14343 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262562AbTFXSRv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 14:17:51 -0400
Date: Tue, 24 Jun 2003 20:31:56 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: John Cherry <cherry@osdl.org>
Cc: Adrian Bunk <bunk@fs.tum.de>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.73 compile results
Message-ID: <20030624183156.GA11266@mars.ravnborg.org>
Mail-Followup-To: John Cherry <cherry@osdl.org>,
	Adrian Bunk <bunk@fs.tum.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1056475577.9839.110.camel@cherrypit.pdx.osdl.net> <20030624173900.GV3710@fs.tum.de> <1056478596.9839.118.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1056478596.9839.118.camel@cherrypit.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 24, 2003 at 11:16:37AM -0700, John Cherry wrote:
> Unfortunately, the build continues even when it runs into compile or
> link errors.
I just wnat to add here that the build continue because 'make -k' is
used because the script counts all errors that occur - not just the first
one is see.

John - any progress in sparse support - or too noisy?

	Sam
