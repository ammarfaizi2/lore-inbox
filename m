Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266332AbUA2Tix (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 14:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266330AbUA2Tix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 14:38:53 -0500
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:32405 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S266328AbUA2Tij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 14:38:39 -0500
Date: Thu, 29 Jan 2004 20:36:13 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.2-rc2, rivafb]: GeForce4 440 Go 64M overflows fb_fix_screeninfo.id
Message-ID: <20040129193612.GA1020@bogon.ms20.nix>
References: <20040129192937.GI5681@vana.vc.cvut.cz> <Pine.LNX.4.44.0401291932320.11251-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401291932320.11251-100000@phoenix.infradead.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 29, 2004 at 07:33:07PM +0000, James Simmons wrote:
> I applied the fbdev.c part but Petr is right. It would break userland.
That's fine. Thanks,
 -- Guido
