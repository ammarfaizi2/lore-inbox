Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316949AbSEWQu0>; Thu, 23 May 2002 12:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316957AbSEWQuZ>; Thu, 23 May 2002 12:50:25 -0400
Received: from pizda.ninka.net ([216.101.162.242]:60129 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316949AbSEWQuX>;
	Thu, 23 May 2002 12:50:23 -0400
Date: Thu, 23 May 2002 09:36:01 -0700 (PDT)
Message-Id: <20020523.093601.20619013.davem@redhat.com>
To: sebastian.droege@gmx.de
Cc: hch@infradead.org, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [2.5.17-cset1.656] patch to compile nfs (and maybe others)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020523184141.6fe51ec2.sebastian.droege@gmx.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Sebastian Droege <sebastian.droege@gmx.de>
   Date: Thu, 23 May 2002 18:41:41 +0200

   Ok... but then we've to copy the FASTCALL stuff (which is used
   elsewhere too) from linkage.h to namei.h or something else...

namei.h should include linkage.h and I sent precisely that
to Linus last evening...

