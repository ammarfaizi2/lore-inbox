Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275758AbRJSAfj>; Thu, 18 Oct 2001 20:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276813AbRJSAfa>; Thu, 18 Oct 2001 20:35:30 -0400
Received: from chac.inf.utfsm.cl ([200.1.19.54]:26126 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S275758AbRJSAfU>;
	Thu, 18 Oct 2001 20:35:20 -0400
Message-Id: <200110190014.f9J0Ej7T016629@sleipnir.valparaiso.cl>
To: James Sutherland <jas88@cam.ac.uk>, Ben Greear <greearb@candelatech.com>,
        Neil Brown <neilb@cse.unsw.edu.au>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: RFC - tree quotas for Linux (2.4.12, ext2) 
In-Reply-To: Message from Mike Fedyk <mfedyk@matchmail.com> 
   of "Thu, 18 Oct 2001 15:56:36 PDT." <20011018155636.B2467@mikef-linux.matchmail.com> 
Date: Thu, 18 Oct 2001 21:14:45 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> said:
> Lets say that you have about 50GB of space, but you only want to allow 20GB
> for a certain tree (possibly mp3s), and you want to keep user ownerships of
> the files they contribute.

Then they just copy the mp3's wherever they want, and symlink them into
the tree. No (meaningful) charge.

BTW, you get (almost exactly) the same effect by mounting a partition of
20Gb under /mp3
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
