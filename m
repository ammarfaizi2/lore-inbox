Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVB0NLB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVB0NLB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 08:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVB0NLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 08:11:01 -0500
Received: from edu.joroinen.fi ([194.89.68.130]:40387 "EHLO edu.joroinen.fi")
	by vger.kernel.org with ESMTP id S261383AbVB0NK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 08:10:29 -0500
Date: Sun, 27 Feb 2005 15:10:27 +0200
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Cc: David Hoffman <dhoffman_98@yahoo.com>
Subject: Re: [RFT] Preliminary w83627ehf hardware monitoring driver
Message-ID: <20050227131027.GM25818@edu.joroinen.fi>
References: <20050226191142.6288b2ef.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050226191142.6288b2ef.khali@linux-fr.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2005 at 07:11:42PM +0100, Jean Delvare wrote:
> Hi all,
> 
> I have been working on a w83627ehf hardware monitoring driver. The
> W83627EHF is a Super-I/O chip made by Winbond. Like other chips of the
> family (W83627HF, W83697HF, W83627THF...), it integrates hardware
> monitoring functions. Of these, my preliminary driver only handles
> temperature and fan inputs at the moment. I lack time and do not have
> hardware to test it, so I will not improve it significantly in a near
> future.
> 

Hi!

Do you know about driver for W83627THF watchdog? I'm using Supermicro P8SCI
motherboard, and I haven't found working driver for it..

Thanks!

-- Pasi Kärkkäinen
       
                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.
