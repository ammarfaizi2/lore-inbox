Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263734AbTKKUVj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 15:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbTKKUVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 15:21:39 -0500
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:15257 "HELO
	cenedra.office") by vger.kernel.org with SMTP id S263734AbTKKUVh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 15:21:37 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net off the air
Date: Tue, 11 Nov 2003 20:21:34 +0000
User-Agent: KMail/1.5.4
References: <fa.eto0cvm.1v20528@ifi.uio.no> <200311111438.47868.andrew@walrond.org> <bore48$ubl$1@cesium.transmeta.com>
In-Reply-To: <bore48$ubl$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311112021.34631.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 Nov 2003 7:43 pm, H. Peter Anvin wrote:
>
> OK... this still doesn't deal with how to get mirrors to pick stuff up
> with a minimum of fuss.  The "minimum of fuss" bit is *extremely*
> important... I still haven't managed to get all mirrors to use rsync.
>

1. Don't bother with cvs.Just host a clone of the main bk repository
2. Persuade Larry to release a 'clone/pull-only' version of bk which *anyone* 
can use to  access open source software
3. Having lit the blue touch paper, run...

Seriously though; There isn't another way that I can see for mirroring cvs 
repos coherently, unless cvsup does something clever? Anyone know?

Andrew Walrond

