Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274752AbRJQGfj>; Wed, 17 Oct 2001 02:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274766AbRJQGfa>; Wed, 17 Oct 2001 02:35:30 -0400
Received: from pizda.ninka.net ([216.101.162.242]:33419 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S274752AbRJQGfX>;
	Wed, 17 Oct 2001 02:35:23 -0400
Date: Tue, 16 Oct 2001 23:35:34 -0700 (PDT)
Message-Id: <20011016.233534.48799017.davem@redhat.com>
To: axboe@suse.de
Cc: cary_dickens2@hp.com, linux-kernel@vger.kernel.org, erik_habbinga@hp.com
Subject: Re: Problem with 2.4.14prex and qlogicfc
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011017081837.C3035@suse.de>
In-Reply-To: <C5C45572D968D411A1B500D0B74FF4A80418D570@xfc01.fc.hp.com>
	<20011017081837.C3035@suse.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jens Axboe <axboe@suse.de>
   Date: Wed, 17 Oct 2001 08:18:37 +0200

   On Tue, Oct 16 2001, DICKENS,CARY (HP-Loveland,ex2) wrote:
   > I'm seeing a problem on all the kernels that are 2.4.13pre1 and up.

   This smells like a bug in the pci64 conversion of qlogicfc. Maybe davem
   has an idea, I'll take a look too.
   
Not if it broke in pre1 since the pci64 stuff went into pre2 :-)

Franks a lot,
David S. Miller
davem@redhat.com
