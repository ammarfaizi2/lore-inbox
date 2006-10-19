Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946330AbWJSSeB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946330AbWJSSeB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 14:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946327AbWJSSeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 14:34:01 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:41964 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1946328AbWJSSd7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 14:33:59 -0400
Date: Thu, 19 Oct 2006 11:33:22 -0700
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "John W. Linville" <linville@tuxdriver.com>
Subject: Re: 2.6.19-rc2-mm1 // errors in verify_redzone_free()
Message-ID: <20061019183322.GB9564@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20061016230645.fed53c5b.akpm@osdl.org> <20061019102529.dea90fec.akpm@osdl.org> <20061019174728.GA9435@bougret.hpl.hp.com> <200610192031.09451.m.kozlowski@tuxland.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610192031.09451.m.kozlowski@tuxland.pl>
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
User-Agent: Mutt/1.5.9i
From: Jean Tourrilhes <jt@hpl.hp.com>
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: jt@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 08:31:09PM +0200, Mariusz Kozlowski wrote:
> Hi, 
> 
> > 	It's the same bug as before.
> > 	The user is *not* using 2.6.19-rc2-mm1, but 2.6.19-rc2 :
> 
> Hmmm ... weird. I did fetch -mm1 with git like this:
> 
> git fetch git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git v2.6.19-rc2-mm1
> 
> then make oldconfig && make && ... Will investigate. Sorry for the noise then.
> 

	No, it was actually helpful. 2.6.19-rc2 should be fixed, I was
expecting my patches were included and was surprised they were not.

> 	Mariusz Kozlowski

	Thanks !

	Jean
