Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVA1KN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVA1KN1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 05:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVA1KN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 05:13:27 -0500
Received: from linux2.cpe.fr ([134.214.50.6]:45033 "EHLO linux2.cpe.fr")
	by vger.kernel.org with ESMTP id S261249AbVA1KNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 05:13:20 -0500
Date: Fri, 28 Jan 2005 11:11:44 +0100
From: Pierre Chifflier <chifflier@cpe.fr>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Applications segfault on evo n620c with 2.6.10
Message-ID: <20050128101144.GE19970@image4.cpe.fr>
References: <20050127184334.GA1368@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050127184334.GA1368@elf.ucw.cz>
Organization: (cpe 'fr)
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 07:43:34PM +0100, Pavel Machek wrote:
> Hi!
> 
> It happened for 3rd in a week now...
> 
> When problem happens, processes start to segfault, usually right
> during startup. Programs that were loaded prior to problem usualy
> works, and can be restarted. I also seen sendmail exec failing with
> "no such file or directory" when it clearly was there. Reboot corrects
> things, and filesystem (ext3) is not damaged.
> 
> Unfortunately I do not know how to reproduce it. I tried
> parallel-building kernels for few hours and that worked okay. Swsusp
> is not involved (but usb, bluetooth, acpi and sound may be).
> 
> Does anyone else see something similar?
> 								Pavel

I have the same laptop and there is no error here.
However, I remember this laptop was affected by a RAM problem, which
could cause these symptoms.

More infos here:
http://www.theregister.co.uk/2004/06/26/hp_ram_recall/

Cheers,

Pierre
