Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314548AbSFXRtp>; Mon, 24 Jun 2002 13:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314553AbSFXRto>; Mon, 24 Jun 2002 13:49:44 -0400
Received: from pizda.ninka.net ([216.101.162.242]:40671 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314548AbSFXRto>;
	Mon, 24 Jun 2002 13:49:44 -0400
Date: Mon, 24 Jun 2002 10:43:37 -0700 (PDT)
Message-Id: <20020624.104337.13391139.davem@redhat.com>
To: fdavis@si.rr.com
Cc: linux-kernel@vger.kernel.org, jfbeam@bluetronic.net
Subject: Re: [PATCH] 2.5.24 : drivers/scsi/dpt_i2o.c (DMA Rev. 2)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0206241320180.901-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0206241320180.901-100000@localhost.localdomain>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Frank Davis <fdavis@si.rr.com>
   Date: Mon, 24 Jun 2002 13:23:14 -0400 (EDT)

     I've added the check for 64-bit DMA addressing per Rick's comment. 

I can guarentee you didn't try to compile that.
