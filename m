Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316258AbSHIXPt>; Fri, 9 Aug 2002 19:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316289AbSHIXPt>; Fri, 9 Aug 2002 19:15:49 -0400
Received: from mail.actcom.co.il ([192.114.47.13]:48520 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S316258AbSHIXPt>; Fri, 9 Aug 2002 19:15:49 -0400
Subject: Re: kernel memory swap..
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: imran.badr@cavium.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <09b101c23fce$398781f0$9e10a8c0@IMRANPC>
References: <09b101c23fce$398781f0$9e10a8c0@IMRANPC>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 10 Aug 2002 02:19:43 +0300
Message-Id: <1028935183.28028.9.camel@gby.benyossef.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-09 at 20:57, Imran Badr wrote:
> 
> Hi,
> 
> If I allocate some memory using kmalloc() in the linux device driver and
> will it ever be swapped to hard disk? If yes, then how can I lock the page?

AFAIK, kmalloced memory is never swapped.

Gilad.

-- 
Gilad Ben-Yossef <gilad@benyossef.com>
http://benyossef.com

"Money talks, bullshit walks and GNU awks."
  -- Shachar "Sun" Shemesh, debt collector for the GNU/Yakuza

