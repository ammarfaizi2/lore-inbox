Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316070AbSG3R4P>; Tue, 30 Jul 2002 13:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316682AbSG3R4O>; Tue, 30 Jul 2002 13:56:14 -0400
Received: from zamok.crans.org ([138.231.136.6]:28340 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id <S316070AbSG3R4O>;
	Tue, 30 Jul 2002 13:56:14 -0400
Date: Tue, 30 Jul 2002 19:59:33 +0200
To: Eric Altendorf <EricAltendorf@orst.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.25: spurious 8259A interrupt: IRQ7
Message-ID: <20020730175932.GA29379@darwin.crans.org>
References: <200207300952.28460.EricAltendorf@orst.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207300952.28460.EricAltendorf@orst.edu>
User-Agent: Mutt/1.4i
X-Warning: Email may contain unsmilyfied humor and/or satire.
From: Vincent Hanquez <tab@crans.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 09:52:28AM -0700, Eric Altendorf wrote:
> 
> This is my first time trying to report a kernel problem, so I have no 
> idea if I'm doing it the right way or not.  I also don't understand 
> the problem; maybe it's my own fault.  Here it goes, though:

This is my first time trying to answer to a kernel report problem :)
 
> [1.] One line summary of the problem:    
> 
> spurious 8259A interrupt: IRQ7. (during heavy disk reads)

There were a discussion about this warning some time ago.
As far as I remember, it's just a interrupt which is not registered by
any peripheral.
this is not a kernel bug, just a buggy hardware.

-- 
Tab
