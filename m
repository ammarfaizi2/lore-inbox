Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290338AbSBORv0>; Fri, 15 Feb 2002 12:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290344AbSBORvT>; Fri, 15 Feb 2002 12:51:19 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:33808
	"EHLO golux.thyrsus.com") by vger.kernel.org with ESMTP
	id <S290338AbSBORvE>; Fri, 15 Feb 2002 12:51:04 -0500
Date: Fri, 15 Feb 2002 12:25:36 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux-Kernel list <linux-kernel@vger.kernel.org>, dirk.hohndel@intel.com
Subject: Re: Disgusted with kbuild developers
Message-ID: <20020215122536.B8249@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Linux-Kernel list <linux-kernel@vger.kernel.org>,
	dirk.hohndel@intel.com
In-Reply-To: <3C6D3D9A.565EC59D@mandrakesoft.com> <20020215115147.A7528@thyrsus.com> <3C6D45E3.59A7D72D@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C6D45E3.59A7D72D@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Feb 15, 2002 at 12:31:15PM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com>:
> What I see on linux-kernel is you writing long diatribes, and then
> promptly ignoring feedback from kernel developers who would actually be
> using your system.  After months and months of being told that
> Configure.help needed to be split up, you just continued to whine. 

I heard Linus say that he wanted Configure.help split up.  I agreed to
do it, too, in CML2.  But I thought I was not supposed to mess with existing 
formats -- in fact, I was afraid to, because you and Al Viro beat me up
so hard about changing *nothing* before cutover.  The CML1 code owns that
format, and I am not the CML1 maintainer.  In fact mec specifically turned
me down when I volunteered for that job; he said he wanted me concentrating
on CML2.

Neither Linus nor anyone else ever said to me "Eric, it's your job to 
make that change."  When I asked for guidance, Linus blackholed my mail.
Was I supposed to be practicing telepathy, here?
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
