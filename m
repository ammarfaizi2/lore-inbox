Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267774AbUIDMcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267774AbUIDMcp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 08:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267793AbUIDMco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 08:32:44 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:11735 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S267774AbUIDMcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 08:32:42 -0400
Date: Sat, 4 Sep 2004 13:32:41 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Whitwell <keith@tungstengraphics.com>, Dave Jones <davej@redhat.com>,
       Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
In-Reply-To: <20040904132142.A14904@infradead.org>
Message-ID: <Pine.LNX.4.58.0409041324170.25475@skynet>
References: <41398EBD.2040900@tungstengraphics.com> <20040904104834.B13362@infradead.org>
 <413997A7.9060406@tungstengraphics.com> <20040904112535.A13750@infradead.org>
 <4139995E.5030505@tungstengraphics.com> <20040904112930.GB2785@redhat.com>
 <4139A9F4.4040702@tungstengraphics.com> <20040904115442.GD2785@redhat.com>
 <4139B03A.6040706@tungstengraphics.com> <Pine.LNX.4.58.0409041311020.25475@skynet>
 <20040904132142.A14904@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Again, how is drm different from scsi or net or whatever drivers except
> that you need a big userlevel component aswell?

Well I've always wondered why I couldn't download drivers for my i845 on
board soundcard for Redhat 9 (back when it was a supported distro), why
the hell did I need to go install FC1 or upgrade my kernel to a non-RH
kernel, same with X on the i845, it was crap on RH9 by the time FC1 came
out the i865 was out, the distros play catchup the whole time with new
hardware, why not allow people to download external drivers and use em?

I do take your point that a vendor supplied kernel update will break
everything anyways, but we do have a lot of proprietary driver users that
deal with this and get support for their hardware why should people
supplying open source drivers be worse off.. and that is my view with the
drm at the moment, companies wanting to do the right things are in a worse
position than companies just releasing binary drivers, and that is just
wrong :-), telling your users to get a new kernel isn't a nice way of
doing things, and maybe Fedora is doing things right, but not many other
distros are...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

