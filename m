Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264297AbRFLJ4E>; Tue, 12 Jun 2001 05:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264300AbRFLJzz>; Tue, 12 Jun 2001 05:55:55 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:5833 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S264297AbRFLJzm>; Tue, 12 Jun 2001 05:55:42 -0400
Date: Tue, 12 Jun 2001 11:53:38 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Roberto Di Cosmo <Roberto.Di-Cosmo@pps.jussieu.fr>,
        linux-kernel@vger.kernel.org, demolinux@demolinux.org,
        dicosmo@pps.jussieu.fr
Subject: Re: [isocompr PATCH]: announcing stable port to kernel 2.2.18
Message-ID: <20010612115338.J754@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <200106110929.f5B9T5Q27584@foobar.pps.jussieu.fr> <20010611225944.B959@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010611225944.B959@bug.ucw.cz>; from pavel@suse.cz on Mon, Jun 11, 2001 at 10:59:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2001 at 10:59:44PM +0200, Pavel Machek wrote:
> > The current version of the patch for 2.2.18 is very stable
> > (we use it for DemoLinux [see www.demolinux.org] heavily),
> > and I wonder if it could not be a good idea to see if this
> > code can be folded into the official releases sometime in the
> > future (I have been looking at 2.4.x code, but the new page
> > cache means some changes might be needed: I will try to post
> > a first version for 2.4.x soon).
> 
> I think that 2.5.0 should be your target... It is definitely new
> feature, and both 2.4.X and 2.2.X are in feature freeze.

Right. And besides: HPA coded a similar patch for 2.4.x, while he
fixed some issues.

So you might try his work or even come to an agreement on the
format.

Regards

Ingo Oeser
-- 
Use ReiserFS to get a faster fsck and Ext2 to fsck slowly and gently.
