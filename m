Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314094AbSEMQRT>; Mon, 13 May 2002 12:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314096AbSEMQRS>; Mon, 13 May 2002 12:17:18 -0400
Received: from fmr02.intel.com ([192.55.52.25]:23494 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S314094AbSEMQRP>; Mon, 13 May 2002 12:17:15 -0400
Message-ID: <D9223EB959A5D511A98F00508B68C20C0BFB7E67@orsmsx108.jf.intel.com>
From: "Woodruff, Robert J" <woody@co.intel.com>
To: "'Pete Zaitcev'" <zaitcev@redhat.com>,
        "Woodruff, Robert J" <woody@co.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Tcp/ip offload card driver
Date: Mon, 13 May 2002 09:17:07 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I would like to keep the BOF on practical topics of Infiniband
>implementation in Linux by any means necessary. TOE people
>are welcome to come back when they have something working,
>and when we know how fast the regular IP over Infiniband can go.

I agree that we should stick mainly to discussing InfiniBand 
at the LSM BOF and let the TOE discussion happen elsewhere,
although the issues of implementing InfiniBand SDP and 
TOE in the kernel are similar as they both want a way to
bypass the S/W TCP stack, but with SDP this could simply be
a new address family, where the TOE guys want a way to dynamically
replace the TCP stack with a TOE driver. 


However, perhaps we should start a new email 
thread to discuss topics of interest for the LSM BOF 
rather than highjack this thread to do so. 

