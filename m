Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316300AbSE3EgG>; Thu, 30 May 2002 00:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316309AbSE3EgF>; Thu, 30 May 2002 00:36:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27146 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316300AbSE3EgF>;
	Thu, 30 May 2002 00:36:05 -0400
Message-ID: <3CF5ABBF.2070109@mandrakesoft.com>
Date: Thu, 30 May 2002 00:34:07 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
CC: Dave Jones <davej@suse.de>, "J.A. Magallon" <jamagallon@able.es>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] intel-x86 model config cleanup
In-Reply-To: <200205300243.g4U2hIZ369399@saturn.cs.uml.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan wrote:

>  
>
>I want one kernel. I have a Pentium-MMX and a Pentium Pro.
>I don't need support for a 386, 486, Athlon, or Xeon.
>  
>


It depends on how much work the patch author wants to do.  This is a 
perfectly reasonable request, but increases the complexity of the 
overall problem somewhat.

Your current solution, whatever it is, should map directly onto one of 
the 'generic kernel' selections, hopefully.  So, what you are really 
asking for is an RFE to add on to this RFE currently being discussed :)

    Jeff




