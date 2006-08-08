Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932527AbWHHIyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbWHHIyZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 04:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbWHHIyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 04:54:25 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:30361 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932527AbWHHIyY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 04:54:24 -0400
Date: Tue, 8 Aug 2006 18:54:06 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Avuton Olrich <avuton@gmail.com>, "Tony.Ho" <linux@idccenter.cn>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-git3 - XFS - BUG: unable to handle kernel NULL pointer dereference at virtual address 00000078
Message-ID: <20060808185405.B2528231@wobbly.melbourne.sgi.com>
References: <9a8748490608040122l69ff139dtaae27e8981022dae@mail.gmail.com> <20060804200549.A2414667@wobbly.melbourne.sgi.com> <44D55CE8.3090202@idccenter.cn> <44D56A97.2070603@idccenter.cn> <20060807143416.A2501392@wobbly.melbourne.sgi.com> <3aa654a40608072039r2b5c5a19hbd3e68e4fee40869@mail.gmail.com> <20060808134438.E2526901@wobbly.melbourne.sgi.com> <9a8748490608080137k596a6290r3567096668449a64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9a8748490608080137k596a6290r3567096668449a64@mail.gmail.com>; from jesper.juhl@gmail.com on Tue, Aug 08, 2006 at 10:37:49AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2006 at 10:37:49AM +0200, Jesper Juhl wrote:
> On 08/08/06, Nathan Scott <nathans@sgi.com> wrote:
> > On Mon, Aug 07, 2006 at 08:39:49PM -0700, Avuton Olrich wrote:
> > > On 8/6/06, Nathan Scott <nathans@sgi.com> wrote:
> > > > On Sun, Aug 06, 2006 at 12:05:43PM +0800, Tony.Ho wrote:
> > > > > I'm sorry about prev mail. I test on a wrong kernel.
> > > > > The panic is not appear again,
> > >
> > > Using 2.6.18-rc4, is this the bug that this thread refers to?
> >
> > Yes, try http://oss.sgi.com/archives/xfs/2006-08/msg00054.html
> > and lemme know what happens - thanks.
> >
> Come wednesday would you like me to try rc4 + that patch instead of
> rc3-git3 with your previous patch?

Yep, ignore that first patch.  Thanks!

-- 
Nathan
