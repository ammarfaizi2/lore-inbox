Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315946AbSIEAen>; Wed, 4 Sep 2002 20:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316437AbSIEAen>; Wed, 4 Sep 2002 20:34:43 -0400
Received: from pizda.ninka.net ([216.101.162.242]:9955 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315946AbSIEAem>;
	Wed, 4 Sep 2002 20:34:42 -0400
Date: Wed, 04 Sep 2002 17:32:14 -0700 (PDT)
Message-Id: <20020904.173214.08949126.davem@redhat.com>
To: reiser@namesys.com
Cc: shaggy@austin.ibm.com, szepe@pinerecords.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org, aurora-sparc-devel@linuxpower.org,
       reiserfs-dev@namesys.com, linuxjfs@us.ibm.com, green@namesys.com
Subject: Re: [reiserfs-dev] Re: [PATCH] sparc32: wrong type of nlink_t
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D76A6FF.509@namesys.com>
References: <3D766DA8.9030207@namesys.com>
	<20020904.163515.82835380.davem@redhat.com>
	<3D76A6FF.509@namesys.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Hans Reiser <reiser@namesys.com>
   Date: Thu, 05 Sep 2002 04:36:15 +0400

   And you would cripple the 99% usage to aid those users who move disk 
   drives physically over to a sparc box AND have more than 31k links to a 
   file?

This is not a sparc or a x86 or x86_64 or ia64 thing.

It's a global thing.

It's about being portable and clean and not installing unnecessary
restrictions.
