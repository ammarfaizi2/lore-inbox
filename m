Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267982AbUBRUGW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 15:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267983AbUBRUGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 15:06:22 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:12160 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S267982AbUBRUGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 15:06:20 -0500
Date: Wed, 18 Feb 2004 21:06:07 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Alexander Hoogerhuis <alexh@ihatent.com>
Cc: Zoltan NAGY <nagyz@nefty.hu>, linux-kernel@vger.kernel.org
Subject: Re: v2.6 in vmware?
Message-ID: <20040218200607.GA12982@vana.vc.cvut.cz>
References: <10ADD433537@vcnet.vc.cvut.cz> <8765e4fayx.fsf@lapper.ihatent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8765e4fayx.fsf@lapper.ihatent.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 08:23:34PM +0100, Alexander Hoogerhuis wrote:
> "Petr Vandrovec" <VANDROVE@vc.cvut.cz> writes:
> 
> > On 18 Feb 04 at 14:37, Zoltan NAGY wrote:
> > > I've been trying to get 2.6.x working in vmware4, but it drops some
> > > oopses during init... I cannot provide details, but I'm sure that it
> > > does not just me who are having problems with it..
> > 
> > Definitely you are... I do not know about any problems with running
> > 2.6.x as a guest under VMware. 
> > 
> 
> There was something about sysenter support or something in that
> general direction; I had Zwane Mwaikambo send me a patch that worked
> around this for pre 4.0.5 vmware, but never got around to test it as I
> upgraded the vmware software.

I have all reasons to believe that this is fixed in 4.0.5. It is definitely
fixed in 4.5.
					Best regards,
						Petr Vandrovec
