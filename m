Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265178AbUBABxJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 20:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265181AbUBABxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 20:53:09 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:61149 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S265178AbUBABxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 20:53:06 -0500
Date: Sun, 1 Feb 2004 02:31:36 +0100
To: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 Speaker
Message-ID: <20040201013136.GA16043@fubini.pci.uni-heidelberg.de>
References: <20040131022540.04278a4a.backblue@netcabo.pt> <20040131081439.GA440@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040131081439.GA440@ucw.cz>
User-Agent: Mutt/1.3.28i
From: Bernd Schubert <Bernd.Schubert@tc.pci.uni-heidelberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 31, 2004 at 09:14:39AM +0100, Vojtech Pavlik wrote:
> On Sat, Jan 31, 2004 at 02:25:40AM +0000, backblue wrote:
> 
> > I'm using 2.6.1 kernel, and my speakers stop's working with 2.6.1,
> > anyone know why? this dont append to me, a couple of friends have the
> > same problem, how can i solve this... 
> 
> You need to enable it. Drivers->Input->Misc->PC-Speaker
>

I was wondering myself why I didn't get any speaker-output, so this is
the solution. However, I'm wondering why this is a sub-option of Input
and not of Sound?

Thanks,
	Bernd
