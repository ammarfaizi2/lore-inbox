Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276707AbRJQQB4>; Wed, 17 Oct 2001 12:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276708AbRJQQBr>; Wed, 17 Oct 2001 12:01:47 -0400
Received: from atlrel6.hp.com ([192.151.27.8]:39950 "HELO atlrel6.hp.com")
	by vger.kernel.org with SMTP id <S276707AbRJQQB2>;
	Wed, 17 Oct 2001 12:01:28 -0400
Message-ID: <C5C45572D968D411A1B500D0B74FF4A80418D572@xfc01.fc.hp.com>
From: "DICKENS,CARY (HP-Loveland,ex2)" <cary_dickens2@hp.com>
To: "'Jens Axboe'" <axboe@suse.de>, "David S. Miller" <davem@redhat.com>
Cc: "DICKENS,CARY (HP-Loveland,ex2)" <cary_dickens2@hp.com>,
        linux-kernel@vger.kernel.org,
        "HABBINGA,ERIK (HP-Loveland,ex1)" <erik_habbinga@hp.com>
Subject: RE: Problem with 2.4.14prex and qlogicfc
Date: Wed, 17 Oct 2001 12:01:54 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> Ah yes, maybe this is my off-by-one or Cary's :-)
> 
> He also writes that it broke with 2.4.10 + block-highmem which has the
> same PCI changes, so that's why I jumped to that conclusion. Cary, can
> you verify that 2.4.13-pre1 _doesn't_ work and that 2.4.12 does?
>

It is my off by one error.  2.4.13-pre1 works as well as 2.4.12.  Sorry
about that.

Cary 
 
