Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262296AbVBVNXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbVBVNXK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 08:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262302AbVBVNXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 08:23:10 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:58348 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S262296AbVBVNXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 08:23:08 -0500
Date: Tue, 22 Feb 2005 23:27:00 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Meelis Roos <mroos@linux.ee>
Message-Id: <20050222232700.0e53cdae.sfr@canb.auug.org.au>
In-Reply-To: <Pine.SOC.4.61.0502221140040.6097@math.ut.ee>
References: <Pine.SOC.4.61.0502221140040.6097@math.ut.ee>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: 2.4 compile errors in 32-bit sys_revcmsg fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2005 11:48:31 +0200 (EET) Meelis Roos <mroos@linux.ee> wrote:
>
> Is a "||" missing, or something else?

Yes, that's all.  I have already sent a fix to Marcelo.  Sorry for the
inconvenience.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
