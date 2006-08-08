Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWHHDo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWHHDo4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 23:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWHHDo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 23:44:56 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:51595 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932343AbWHHDoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 23:44:55 -0400
Date: Tue, 8 Aug 2006 13:44:38 +1000
From: Nathan Scott <nathans@sgi.com>
To: Avuton Olrich <avuton@gmail.com>
Cc: "Tony.Ho" <linux@idccenter.cn>, jesper.juhl@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-git3 - XFS - BUG: unable to handle kernel NULL pointer dereference at virtual address 00000078
Message-ID: <20060808134438.E2526901@wobbly.melbourne.sgi.com>
References: <9a8748490608040122l69ff139dtaae27e8981022dae@mail.gmail.com> <20060804200549.A2414667@wobbly.melbourne.sgi.com> <44D55CE8.3090202@idccenter.cn> <44D56A97.2070603@idccenter.cn> <20060807143416.A2501392@wobbly.melbourne.sgi.com> <3aa654a40608072039r2b5c5a19hbd3e68e4fee40869@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3aa654a40608072039r2b5c5a19hbd3e68e4fee40869@mail.gmail.com>; from avuton@gmail.com on Mon, Aug 07, 2006 at 08:39:49PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2006 at 08:39:49PM -0700, Avuton Olrich wrote:
> On 8/6/06, Nathan Scott <nathans@sgi.com> wrote:
> > On Sun, Aug 06, 2006 at 12:05:43PM +0800, Tony.Ho wrote:
> > > I'm sorry about prev mail. I test on a wrong kernel.
> > > The panic is not appear again,
> 
> Using 2.6.18-rc4, is this the bug that this thread refers to?

Yes, try http://oss.sgi.com/archives/xfs/2006-08/msg00054.html
and lemme know what happens - thanks.

cheers.

-- 
Nathan
