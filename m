Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262222AbSIZHOq>; Thu, 26 Sep 2002 03:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262223AbSIZHOp>; Thu, 26 Sep 2002 03:14:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:18564 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262222AbSIZHOp>;
	Thu, 26 Sep 2002 03:14:45 -0400
Date: Thu, 26 Sep 2002 00:13:43 -0700 (PDT)
Message-Id: <20020926.001343.57159108.davem@redhat.com>
To: jgarzik@pobox.com
Cc: wli@holomorphy.com, axboe@suse.de, akpm@digeo.com,
       linux-kernel@vger.kernel.org, patman@us.ibm.com, andmike@us.ibm.com
Subject: Re: [PATCH] deadline io scheduler
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D92B450.2090805@pobox.com>
References: <20020926070615.GX22942@holomorphy.com>
	<20020926.000620.27781675.davem@redhat.com>
	<3D92B450.2090805@pobox.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Garzik <jgarzik@pobox.com>
   Date: Thu, 26 Sep 2002 03:16:32 -0400

   David S. Miller wrote:
   > I think it's high time to blow away qlogic{fc,isp}.c and put
   > Matt Jacob's qlogic stuff into 2.5.x
   
   Seconded.  Thanks for remembering that name.
   
No problem :)

   Has his stuff been cleaned up, code-wise, in the past few years?  My 
   experience with it was 100% positive from a technical standpoint, but 
   negative from a style standpoint...
   
I think it'll be less work to toss his stuff into the tree
and have some janitor whack on it than try to get someone
to maintain what we have now.
