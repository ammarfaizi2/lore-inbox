Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265865AbSKDGyW>; Mon, 4 Nov 2002 01:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265908AbSKDGyW>; Mon, 4 Nov 2002 01:54:22 -0500
Received: from pizda.ninka.net ([216.101.162.242]:13280 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265865AbSKDGyV>;
	Mon, 4 Nov 2002 01:54:21 -0500
Date: Sun, 03 Nov 2002 22:50:36 -0800 (PST)
Message-Id: <20021103.225036.99063973.davem@redhat.com>
To: zaitcev@redhat.com
Cc: kai-germaschewski@uiowa.edu, willy@debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: invalid character 45 in exportstr for include-config
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021103142223.A10629@devserv.devel.redhat.com>
References: <1036304411.17126.1.camel@rth.ninka.net>
	<Pine.LNX.4.44.0211031314290.17026-100000@chaos.physics.uiowa.edu>
	<20021103142223.A10629@devserv.devel.redhat.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pete Zaitcev <zaitcev@redhat.com>
   Date: Sun, 3 Nov 2002 14:22:23 -0500
   
   > Makes me wonder if Pete's exporting of 'INIT-Y' is a good idea, you may 
   > want to change that to '_' as well.
   
   Sorry about that. It's already submitted, so I'll wait until
   it recycles through Dave's tree then change it. Thanks for letting
   me know, Kai.

None of your patches are applied yes, please feel free to submit
a new batch and I will wait for that.
