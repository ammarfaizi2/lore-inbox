Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133009AbRD3JkO>; Mon, 30 Apr 2001 05:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133061AbRD3JkF>; Mon, 30 Apr 2001 05:40:05 -0400
Received: from 8.ylenurme.ee ([193.40.6.8]:28686 "EHLO ns.linking.ee")
	by vger.kernel.org with ESMTP id <S133009AbRD3Jju>;
	Mon, 30 Apr 2001 05:39:50 -0400
Date: Mon, 30 Apr 2001 11:38:08 +0200 (GMT-2)
From: Elmer Joandi <elmer@linking.ee>
To: Ookhoi <ookhoi@dds.nl>
cc: Francois Gouget <fgouget@free.fr>, linux-kernel@vger.kernel.org,
        elmer@ylenurme.ee
Subject: Re: Aironet doesn't work
In-Reply-To: <20010430113117.F324@humilis>
Message-ID: <Pine.LNX.4.21.0104301133110.9957-100000@ns.linking.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



the whole pcmcia does not work in 2.4.
Not with latest cardmgr.

What makes airo_cs to work is that pcmcia package
and kernel modules are replaced.
That is what most of distros do.
Which overwrites kernel standard ones and really fucks things up
for pcmcia drivers being in kernel.



Elmer.


