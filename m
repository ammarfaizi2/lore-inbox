Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUD2IEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUD2IEv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 04:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263671AbUD2IEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 04:04:50 -0400
Received: from levante.wiggy.net ([195.85.225.139]:40875 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S263654AbUD2IEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 04:04:44 -0400
Date: Thu, 29 Apr 2004 10:04:44 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Questions : disk partition re-reading
Message-ID: <20040429080443.GG4437@wiggy.net>
Mail-Followup-To: Andries Brouwer <aebr@win.tue.nl>,
	linux-kernel@vger.kernel.org
References: <4082819E.10106@free.fr> <20040420074650.GA3040@pclin040.win.tue.nl> <20040420143634.GA12132@bitwizard.nl> <20040425221528.GB3040@pclin040.win.tue.nl> <20040426083142.GA26429@wiggy.net> <20040429001559.GB4068@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429001559.GB4068@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Andries Brouwer wrote:
> It depends on what you want to do.
> It really works, or at least really worked when I last tried it.
> There are no problems that I know of.

If it works as advertised I'm happy with it. I'm just asking you to make
it a proper part of util-linux in its next release so it will actually be 
installed for people without having to manually compile and install it
seperately from the other utilities in util-linux.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.

