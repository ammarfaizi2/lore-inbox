Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311884AbSEXViT>; Fri, 24 May 2002 17:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311885AbSEXViS>; Fri, 24 May 2002 17:38:18 -0400
Received: from pizda.ninka.net ([216.101.162.242]:12931 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S311884AbSEXViS>;
	Fri, 24 May 2002 17:38:18 -0400
Date: Fri, 24 May 2002 14:23:26 -0700 (PDT)
Message-Id: <20020524.142326.64088347.davem@redhat.com>
To: spy9599@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Few comments on TCP implementation
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020524.142009.51764018.davem@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "David S. Miller" <davem@redhat.com>
   Date: Fri, 24 May 2002 14:20:09 -0700 (PDT)

      Implementing something based on someone's random
      publications is not a good idea for an operating as
      pervasive as Linux.

And to make my point even more clear, most of the algorithms we have
adopted were adopted based upon real testing done in real life
environments.

Take a good hard look at any other OS you think is "pervasive" and I
guarentee you they implement things like rate halving and the various
SACK algorithms.
