Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316903AbSFQR40>; Mon, 17 Jun 2002 13:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316906AbSFQR4Z>; Mon, 17 Jun 2002 13:56:25 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:29453 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S316903AbSFQR4Y>; Mon, 17 Jun 2002 13:56:24 -0400
Date: Mon, 17 Jun 2002 19:49:23 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Kurt Garloff <garloff@suse.de>, Richard Gooch <rgooch@ras.ucalgary.ca>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: /proc/scsi/map
Message-ID: <20020617194923.O22429@nightmaster.csn.tu-chemnitz.de>
References: <20020615133606.GC11016@gum01m.etpnet.phys.tue.nl> <200206151552.g5FFqCT14714@vindaloo.ras.ucalgary.ca> <20020616194111.GA21461@gum01m.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20020616194111.GA21461@gum01m.etpnet.phys.tue.nl>; from garloff@suse.de on Sun, Jun 16, 2002 at 09:41:12PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 16, 2002 at 09:41:12PM +0200, Kurt Garloff wrote:
> I don't want to bash devfs and I think it's nice that it's in the kernel, 
> so users have the choice to use it and the motivation to improve it.
> 
> But the problem that I wanted to address IMHO should also be solved
> for those people that for one or another reason decided not to use
> devfs. 

So make it optional too. I don't need this kind of code
duplication, because I use devfs and I consider it bloat.

And if you do this kind of change, why not implementing
persistent naming for ALL devices?

Other devices have the very same problem.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
