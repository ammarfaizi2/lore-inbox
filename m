Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273622AbRJDOA4>; Thu, 4 Oct 2001 10:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273702AbRJDOAq>; Thu, 4 Oct 2001 10:00:46 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:24543 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S273622AbRJDOAa>; Thu, 4 Oct 2001 10:00:30 -0400
Message-ID: <3BBC6BBD.128161B5@nortelnetworks.com>
Date: Thu, 04 Oct 2001 10:01:33 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: specific optimizations for unaccelerated framebuffers
In-Reply-To: <20011004123118.49603.qmail@web11806.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Etienne Lorrain wrote:

>   Been able to DMA the complete video memory image around 5-10 times/second
>  should be over the human eye sensitivity.

Since anything less than 75Hz gives me headaches, how do you propose to make
this work?

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
