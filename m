Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbTKYCFn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 21:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbTKYCFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 21:05:43 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:44449 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S261842AbTKYCFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 21:05:39 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Albert Cahalan <albert@users.sourceforge.net>
Date: Tue, 25 Nov 2003 13:05:26 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16322.47334.29252.724441@notabene.cse.unsw.edu.au>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       oliver@neukum.name, aliakc@web.de, lenehan@twibble.org,
       mingo@redhat.com
Subject: Re: kernel BUG at raid5.c:337!
In-Reply-To: message from Albert Cahalan on  November 24
References: <1069721971.723.408.camel@cube>
X-Mailer: VM 7.17 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  November 24, albert@users.sourceforge.net wrote:
> Got a picture of a crash on a kiosk or something, as
> a Linux example in Slashdot's public BSOD sightings...
> 
> http://w3.physics.uiuc.edu/~menscher/tekram1.jpg
> 
> So... unknown kernel version, but there's a
> line number that ought to narrow things down.
> 
> Can anybody help this guy?  :-)
> 

Well, given that it could be any release, pre-release, vendor, or
local-patched kernel since 2.2.something, even if you found one with a
BUG at raid5.c:337 you couldn't be sure that you had found the right
one, the only suggestion that I would have, assuming the owner of the
machine wanted a suggestion, is "Upgrade to a current kernel".

NeilBrown

