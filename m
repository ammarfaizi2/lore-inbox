Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312248AbSDIXea>; Tue, 9 Apr 2002 19:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312254AbSDIXe3>; Tue, 9 Apr 2002 19:34:29 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:1266
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S312248AbSDIXe2>; Tue, 9 Apr 2002 19:34:28 -0400
Date: Tue, 9 Apr 2002 16:36:31 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Dominik Kubla <kubla@sciobyte.de>
Cc: linux-kernel@vger.kernel.org, "Alexis S. L. Carvalho" <alexis@cecm.usp.br>
Subject: Re: implementing soft-updates
Message-ID: <20020409233631.GB23513@matchmail.com>
Mail-Followup-To: Dominik Kubla <kubla@sciobyte.de>,
	linux-kernel@vger.kernel.org,
	"Alexis S. L. Carvalho" <alexis@cecm.usp.br>
In-Reply-To: <20020409184605.A13621@cecm.usp.br> <20020409221725.GA23513@matchmail.com> <20020409222337.GB31954@duron.intern.kubla.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2002 at 12:23:37AM +0200, Dominik Kubla wrote:
> On Tue, Apr 09, 2002 at 03:17:25PM -0700, Mike Fedyk wrote:
> > On Tue, Apr 09, 2002 at 06:46:05PM -0300, Alexis S. L. Carvalho wrote:
> > > Hi
> > > 
> > > Does anyone know of any implementation of soft-updates over ext2? I'm
> > > starting a project on this for grad school, and I'd like to know of any
> > > previous (current?) efforts.
> > > 
> > 
> > Heh, ext3? ;)
> 
> No. Ext3 uses journalling. Soft-updates is something different.
> 

Yes, I know that... (don't for get the ";)"...)

Sorry, I don't know if anyone else has started anyting like this.

It would be interesting to see how the locking would work compared to ext3.

You might get more responces from:

ext2-devel@lists.sourceforge.net
 -and-
ext3-users@redhat.com

Since that's where the ext2/3 guys hang out.

Mike
