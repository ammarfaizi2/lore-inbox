Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263468AbUATDHG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 22:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265172AbUATDHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 22:07:06 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:750 "EHLO fed1mtao05.cox.net")
	by vger.kernel.org with ESMTP id S263468AbUATDHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 22:07:03 -0500
Date: Mon, 19 Jan 2004 20:07:35 -0700
From: Jesse Allen <the3dfxdude@hotmail.com>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org
Subject: Re: nforce2 bios fix
Message-ID: <20040120030735.GA764@tesore.local>
Mail-Followup-To: Jesse Allen <the3dfxdude@hotmail.com>,
	"Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
	B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org
References: <40092D69.3070005@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40092D69.3070005@gmx.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 17, 2004 at 01:41:13PM +0100, Prakash K. Cheemplavam wrote:
> [from Bart]
> If BIOS upgrade helped please send 'lspci -vvv -xxx' output from system
> after/before BIOS upgrade, so we can try to catch the problem and add a fix
> to kernel (there is no BIOS update for some motherboards).
> 
> 
> Can't you try above?
> 
> Prakash

OK I flashed back and got both.  The message you refer to is at:
http://marc.theaimsgroup.com/?l=linux-kernel&m=107434138423359&w=2

The other guy has an a7n8x.  Remember that I have a Shuttle AN35N and the BIOS 
as of 12-5-2003 fixes the lockup.  The change log for this BIOS even includes 
the related "Add C1 disconnect option".  I'm still running the pre-Dec-5 BIOS 
so if there is anything else to try I can do it now.

Jesse
