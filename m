Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315223AbSEXUlK>; Fri, 24 May 2002 16:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317249AbSEXUlJ>; Fri, 24 May 2002 16:41:09 -0400
Received: from pizda.ninka.net ([216.101.162.242]:36482 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315223AbSEXUlI>;
	Fri, 24 May 2002 16:41:08 -0400
Date: Fri, 24 May 2002 13:26:41 -0700 (PDT)
Message-Id: <20020524.132641.104219414.davem@redhat.com>
To: wjhun@ayrnetworks.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible discrepancy regarding streaming DMA mappings in
 DMA-mapping.txt?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020524133711.K7205@ayrnetworks.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I know what you're trying to do, but I'm going to tell you upfront
that this will make the existing case much more inefficient than
it needs to be.

Please, add a new call to handle your case.  Thanks.
