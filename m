Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316258AbSIEGnC>; Thu, 5 Sep 2002 02:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317101AbSIEGnC>; Thu, 5 Sep 2002 02:43:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:11238 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316258AbSIEGnC>;
	Thu, 5 Sep 2002 02:43:02 -0400
Date: Wed, 04 Sep 2002 23:40:19 -0700 (PDT)
Message-Id: <20020904.234019.130517085.davem@redhat.com>
To: bof@bof.de
Cc: rusty@rustcorp.com.au, ak@suse.de, laforge@gnumonks.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: ip_conntrack_hash() problem
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020905083932.F19551@oknodo.bof.de>
References: <20020905083340.E19551@oknodo.bof.de>
	<20020904.233226.108195359.davem@redhat.com>
	<20020905083932.F19551@oknodo.bof.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Patrick Schaaf <bof@bof.de>
   Date: Thu, 5 Sep 2002 08:39:32 +0200
   
   Sorry, but I was under the impression that code readability was worth
   the occasional static-global additional 4 bytes. I must have been
   mistaken.

For the level of readability you're pining for, yes you are
mistaken.
