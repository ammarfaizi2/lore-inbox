Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262625AbVCVLHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbVCVLHk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 06:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbVCVLHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 06:07:40 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:60577 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S262625AbVCVLHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 06:07:34 -0500
Date: Tue, 22 Mar 2005 12:06:10 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: S2R gone with 2.6.12-rc1-mm1
Message-ID: <20050322110610.GB1940@gamma.logic.tuwien.ac.at>
References: <20050321210411.GB29072@gamma.logic.tuwien.ac.at> <20050321132106.3cb48d38.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050321132106.3cb48d38.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mär 2005, Andrew Morton wrote:
> > Sorry to bother you again, but I found that S2R does not work anymore
> > with 2.6.12-rc1-mm1, while it works with the exact same software setup
> > with 2.6.11-mm4.
> 
> Oh.  suspend-to-RAM.
> 
> Would this be an ACPI regression?

Sorry for the S2R. I guess that it is related to the new ACPI stuff
introduced in bk-acpi lately. What would you suggest:

Taking the bk-acpi patch from 2.6.11-mm4 and use it instead of the one
in 2.6.12-rc1-mm1? I guess this will not really work?!

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>                 Università di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
HALCRO (n.)
An adhesive fibrous cloth used to hold babies' clothes
together. Thousands of tiny pieces of jam 'hook' on to thousands of
tiny-pieces of dribble, enabling the cloth to become 'sticky'.
			--- Douglas Adams, The Meaning of Liff
