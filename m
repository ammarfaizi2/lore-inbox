Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbVF1CXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbVF1CXz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 22:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbVF1CXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 22:23:55 -0400
Received: from smtpout5.uol.com.br ([200.221.4.196]:51962 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S262382AbVF1CWv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 22:22:51 -0400
Date: Mon, 27 Jun 2005 23:22:36 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: Problems with Firewire and -mm kernels (was: Re: 2.6.12-mm2)
Message-ID: <20050628022236.GB3921@ime.usp.br>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
References: <20050626040329.3849cf68.akpm@osdl.org> <42BE99C3.9080307@trex.wsi.edu.pl> <20050627025059.GC10920@ime.usp.br> <20050627164540.7ded07fc.akpm@osdl.org> <20050628010052.GA3947@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050628010052.GA3947@ime.usp.br>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew.

On Jun 27 2005, Rogério Brito wrote:
> Ok, I put them both on <http://www.ime.usp.br/~rbrito/bug/>.
(...)
> P.S.: I just noticed right now that the patch listed above changes only
> arch/i386/pci/acpi.c, but I am not using ACPI. Well, I will proceed anyway.

Well, as I felt before, backing out the patch didn't work. I posted the
dmesg of the new compilation on the page above like I did before.

Is there any other patch that I should try to revert?


Thanks, Rogério.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
