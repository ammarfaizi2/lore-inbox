Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315204AbSEPXm6>; Thu, 16 May 2002 19:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315212AbSEPXm5>; Thu, 16 May 2002 19:42:57 -0400
Received: from fmr02.intel.com ([192.55.52.25]:60111 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S315204AbSEPXm4>; Thu, 16 May 2002 19:42:56 -0400
Message-ID: <D9223EB959A5D511A98F00508B68C20C0BFB7E9B@orsmsx108.jf.intel.com>
From: "Woodruff, Robert J" <woody@co.intel.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
        "Woodruff, Robert J" <woody@co.intel.com>
Cc: russ@elegant-software.com, Tony.P.Lee@nokia.com, wookie@osdl.org,
        lmb@suse.de, "Woodruff, Robert J" <woody@co.intel.com>,
        linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: RE: InfiniBand BOF @ LSM - topics of interest
Date: Thu, 16 May 2002 16:42:42 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> so someone could invent a new address family for sockets,
> say AF_INFINIBANDO, that is much more light weight than the existing
TCP/IP
> stack.
> Thus with a small change to the application, a good performance increase
can
> be attained.

>Shouldn't be too hard. It looks like its basically AF_PACKET combined with
>the infiniband notions of security.

Maybe a little higher level than raw packets, but yes, 
a light-weight sockets protocol driver. 
