Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276982AbRJQQwJ>; Wed, 17 Oct 2001 12:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276984AbRJQQwA>; Wed, 17 Oct 2001 12:52:00 -0400
Received: from pizda.ninka.net ([216.101.162.242]:11648 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S276982AbRJQQvv>;
	Wed, 17 Oct 2001 12:51:51 -0400
Date: Wed, 17 Oct 2001 09:52:09 -0700 (PDT)
Message-Id: <20011017.095209.39155760.davem@redhat.com>
To: cary_dickens2@hp.com
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, erik_habbinga@hp.com
Subject: Re: Problem with 2.4.14prex and qlogicfc
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <C5C45572D968D411A1B500D0B74FF4A80418D572@xfc01.fc.hp.com>
In-Reply-To: <C5C45572D968D411A1B500D0B74FF4A80418D572@xfc01.fc.hp.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "DICKENS,CARY (HP-Loveland,ex2)" <cary_dickens2@hp.com>
   Date: Wed, 17 Oct 2001 12:01:54 -0400
   
   It is my off by one error.  2.4.13-pre1 works as well as 2.4.12.  Sorry
   about that.

So now please try the broken 2.4.13-preX kernels with
CONFIG_SCSI_QLOGIC_FC_FIRMWARE set, does that
make any difference?

I have a feeling that will make it work.

Franks a lot,
David S. Miller
davem@redhat.com
