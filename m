Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263984AbTDNV4C (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263986AbTDNV4C (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:56:02 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:45578
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263984AbTDNVz7 
	(for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 17:55:59 -0400
Subject: Re: 2.5 'what to expect' document.
From: Robert Love <rml@tech9.net>
To: Valdis.Kletnieks@vt.edu
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200304142159.h3ELxrIO017333@turing-police.cc.vt.edu>
References: <20030414193138.GA24870@suse.de>
	 <20030414214807.GB993@mars.ravnborg.org>
	 <200304142159.h3ELxrIO017333@turing-police.cc.vt.edu>
Content-Type: text/plain
Organization: 
Message-Id: <1050358073.3664.91.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 14 Apr 2003 18:07:53 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-14 at 17:59, Valdis.Kletnieks@vt.edu wrote:

> Only if you're REALLY REALLY sure that you're never going to boot a
> kernel that doesn't have the pdflush daemon functionality in it.  This
> might be an issue if you still need to boot a 2.2 kernel (I think 2.4
> has had the pdflush stuff in it since 2.4.mumble).  I'm sure somebody
> can give a definitive answer when pdflush became mainline kernel....

2.4 does not have pdflush, but it has has bdflush, which doesn't need
/sbin/update either...

	Robert Love

