Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269673AbRIDWVe>; Tue, 4 Sep 2001 18:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269651AbRIDWVY>; Tue, 4 Sep 2001 18:21:24 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15884 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269673AbRIDWVO>; Tue, 4 Sep 2001 18:21:14 -0400
Message-ID: <3B9553DA.9070000@zytor.com>
Date: Tue, 04 Sep 2001 15:21:14 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010801
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, arjanv@redhat.com,
        linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Daniel Quinlan <quinlan@transmeta.com>
Subject: First cut of zisofs with unified zlib
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I have uploaded a patch for zisofs with a "unified" zlib shared with 
cramfs.  It probably can be extended for at least other fs uses, but it 
currently doesn't include compression.

I would appreciate testing as well as comments.

The patch is against 2.4.9-ac7.

ftp://ftp.kernel.org/pub/linux/kernel/people/hpa/zisofs-unified-2.4.9-ac7.diff.gz

Thanks,

	-hpa

