Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbUKOAQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbUKOAQx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 19:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbUKOAQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 19:16:52 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:31108 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261381AbUKOAQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 19:16:51 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jurriaan <thunder7@xs4all.nl>
Date: Mon, 15 Nov 2004 11:20:31 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16791.63055.872365.908963@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: md linear personality oops on boot with 2.6.10-rc1-mm4 and 2.6.10-rc1-mm5
In-Reply-To: message from Jurriaan on Saturday November 13
References: <20041112143012.GA3676@middle.of.nowhere>
	<16789.46845.6950.773945@cse.unsw.edu.au>
	<20041113121628.GA3045@middle.of.nowhere>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday November 13, thunder7@xs4all.nl wrote:
> > 
> > Please verify that this patch fixes it.
> > 
> Excellent, this makes 2.6.10-rc1-mm5 boot without any problems.
> 

Thanks. I'll make sure it gets up-stream.

NeilBrown
