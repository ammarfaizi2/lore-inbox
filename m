Return-Path: <linux-kernel-owner+w=401wt.eu-S1755382AbXABQxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755382AbXABQxy (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 11:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755377AbXABQxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 11:53:53 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:45641 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755382AbXABQxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 11:53:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=U2S0USKikrQSdpBYqMTnNSGVfQW4QNLhsSIObnCexMt1Uvi/Y0or+ciXjgn2jx0bnTWTUix2B8xxOz011FNO7IK5KVQgoqJf9JkWsiaQirpVa8dMiwgbAWI/+b+rNAFswuAgGhfMHuL6t/YqgeHpJLDTgiyYvOfUG6FWSCW0LnU=
Message-ID: <459A8E17.80601@gmail.com>
Date: Wed, 03 Jan 2007 01:53:43 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: Jens Axboe <jens.axboe@oracle.com>, Rene Herman <rene.herman@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.20-rc2+: CFQ halving disk throughput.
References: <45893CAD.9050909@gmail.com> <45921E73.1080601@gmail.com> <4592B25A.4040906@gmail.com> <45932AF1.9040900@gmail.com> <45998F62.6010904@gmail.com> <4599992D.8000607@rtr.ca> <20070102083414.GQ2483@kernel.dk> <459A73CB.8010901@rtr.ca>
In-Reply-To: <459A73CB.8010901@rtr.ca>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> The code (written 10 years ago) isn't the best in the world,
> and will be redone entirely for hdparm-7.0 this year.

OT but care to make -i and -I work equivalently?  Such that -i reports
more detailed info and user can dump stored id block.  Support for
IDENTIFY PACKET DEVICE would be nice too.

Thanks.

-- 
tejun
