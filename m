Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265203AbUGLQvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265203AbUGLQvy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 12:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266887AbUGLQvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 12:51:54 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:49290 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265203AbUGLQvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 12:51:53 -0400
Date: Mon, 12 Jul 2004 12:51:52 -0400
From: Andrew Pimlott <andrew@pimlott.net>
To: Andreas Schwab <schwab@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
Message-ID: <20040712165152.GA6814@pimlott.net>
Mail-Followup-To: Andrew Pimlott <andrew@pimlott.net>,
	Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au> <Pine.LNX.4.58.0407080917420.1764@ppc970.osdl.org> <40ED7BE7.7010506@techsource.com> <200407090056.51084.vda@port.imtp.ilyichevsk.odessa.ua> <40F2AB82.40508@techsource.com> <jeisct2oig.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jeisct2oig.fsf@sykes.suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2004 at 06:12:23PM +0200, Andreas Schwab wrote:
> If your function needs nine arguments it is not readable by
> definition. :-)

"If you have a procedure with ten parameters, you probably missed some."
- Alan Perlis

Andrew
