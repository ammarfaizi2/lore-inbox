Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135701AbRD2JR5>; Sun, 29 Apr 2001 05:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135704AbRD2JRr>; Sun, 29 Apr 2001 05:17:47 -0400
Received: from mailg.telia.com ([194.22.194.26]:54237 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id <S135701AbRD2JRi>;
	Sun, 29 Apr 2001 05:17:38 -0400
Message-ID: <3AEBDC24.A6C55D05@canit.se>
Date: Sun, 29 Apr 2001 11:17:24 +0200
From: Kenneth Johansson <ken@canit.se>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jonathan Lundell <jlundell@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2GB swap partition limit
In-Reply-To: <200104281804.f3SI4ar368494@saturn.cs.uml.edu> <p05100304b71121ec85c7@[207.213.213.109]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Lundell wrote:

>
> (Does Linux swap out text, by the way, he asks ignorantly?)

.text is just droped and read back from the actuall file it's not put into the swap

