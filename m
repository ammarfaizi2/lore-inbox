Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272045AbRHVQTD>; Wed, 22 Aug 2001 12:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272047AbRHVQSx>; Wed, 22 Aug 2001 12:18:53 -0400
Received: from pizda.ninka.net ([216.101.162.242]:6827 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S272045AbRHVQSi>;
	Wed, 22 Aug 2001 12:18:38 -0400
Date: Wed, 22 Aug 2001 09:18:44 -0700 (PDT)
Message-Id: <20010822.091844.107697331.davem@redhat.com>
To: tavy@igreconline.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bug in sendto() causes OOPS when using RAW sockets
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200108221607.f7MG7a501809@www.igreconline.com>
In-Reply-To: <200108221607.f7MG7a501809@www.igreconline.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Octavian Cerna" <tavy@igreconline.com>
   Date: Wed, 22 Aug 2001 19:07:36 +0300
    
   I attached a small patch to fix this issue, a C program for testing the
   problem and my OOPS log.
    
Thanks, I've applied your fix to my tree.

Later,
David S. Miller
davem@redhat.com
