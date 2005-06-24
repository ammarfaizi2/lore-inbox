Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263254AbVFXLwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263254AbVFXLwa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 07:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263258AbVFXLwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 07:52:30 -0400
Received: from ns.suse.de ([195.135.220.2]:64400 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S263254AbVFXLuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 07:50:11 -0400
From: Chris Mason <mason@suse.com>
To: jmerkey <jmerkey@utah-nac.org>
Subject: Re: Novell Linux Kernel Debugger (NLKD)
Date: Fri, 24 Jun 2005 07:50:02 -0400
User-Agent: KMail/1.8
Cc: Jan Beulich <JBeulich@novell.com>,
       Christoph Lameter <christoph@lameter.com>,
       Clyde Griffin <CGRIFFIN@novell.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       linux-kernel@vger.kernel.org
References: <s2bae938.075@sinclair.provo.novell.com> <42BBC297020000780001D4A5@emea1-mh.id2.novell.com> <42BB932D.9050808@utah-nac.org>
In-Reply-To: <42BB932D.9050808@utah-nac.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506240750.03736.mason@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 June 2005 00:59, jmerkey wrote:
> Jan Beulich wrote:
> >>It's a GBD replacement and is not fully open source.
> >
> >What is not open source in it ()?
> >
> >>KDB is at present more capable. It has a lot of promise, but it does not
> >>have the all the architectural
> >>features necessary to replace either KDB or GDB at present.
> >
> >While I never used or saw kdb, I'd be curious about what you immediately
> > saw missing...
>
> 1. No back trace
> 2. Doesn't run standalone fully embeded in the kernel
> 3. Not fully open source (since it's not embeded in the kernel)
> 4. IA64 doesn't really matter, since IA64 is basically dead anyway
> 5. No advanced recursive descent parser for conditional breakpoints

This is more or less completely inaccurate.

-chris


