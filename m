Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932550AbWGSWB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbWGSWB4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 18:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932552AbWGSWB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 18:01:56 -0400
Received: from mail.gmx.net ([213.165.64.21]:26081 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932550AbWGSWBz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 18:01:55 -0400
X-Authenticated: #428038
Date: Thu, 20 Jul 2006 00:01:51 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Valdis.Kletnieks@vt.edu, Tilman Schmidt <tilman@imap.cc>,
       Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Matthias Andree <matthias.andree@gmx.de>,
       Grzegorz Kulewski <kangur@polcom.net>,
       Diego Calleja <diegocg@gmail.com>, arjan@infradead.org,
       caleb@calebgray.com
Subject: Re: Reiser4 Inclusion
Message-ID: <20060719220151.GC28193@merlin.emma.line.org>
Mail-Followup-To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
	Valdis.Kletnieks@vt.edu, Tilman Schmidt <tilman@imap.cc>,
	Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Grzegorz Kulewski <kangur@polcom.net>,
	Diego Calleja <diegocg@gmail.com>, arjan@infradead.org,
	caleb@calebgray.com
References: <20060717160618.013ea282.diegocg@gmail.com> <Pine.LNX.4.63.0607171611080.10427@alpha.polcom.net> <20060717155151.GD8276@merlin.emma.line.org> <Pine.LNX.4.61.0607180951480.16615@yvahk01.tjqt.qr> <20060718204718.GD18909@merlin.emma.line.org> <fake-message-id-1@fake-server.fake-domain> <84144f020607190403y1a659c99oc795ae244390c2ee@mail.gmail.com> <44BE50A0.9070107@imap.cc> <200607191904.k6JJ4cf0002159@turing-police.cc.vt.edu> <44BE9620.9080400@wolfmountaingroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44BE9620.9080400@wolfmountaingroup.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.12 (2006-07-17)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2006, Jeff V. Merkey wrote:

> Projects I have taken commercial are big money makers and obviously will 
> not be submitted to the tree.

So let's hope they're in compliance with the GPL...

> Reiser is shipped in Suse Linux as the default, so who cares whether
> its in the tree or not

That is Reiserfs 3.6 which was officially discontinued by its
maintainers, and has rather little relevance to the discussion: no
reiser4 or dropping 3.X support was on the horizon when reiserfs 3.5 was
merged (and messed up horribly when NFS exported).

-- 
Matthias Andree
