Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263307AbREWW4j>; Wed, 23 May 2001 18:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263311AbREWW4d>; Wed, 23 May 2001 18:56:33 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:59537 "EHLO
	e34.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263306AbREWW4H>; Wed, 23 May 2001 18:56:07 -0400
Message-ID: <3B0C3F87.1B21F5D5@vnet.ibm.com>
Date: Wed, 23 May 2001 22:53:59 +0000
From: Tom Gall <tom_gall@vnet.ibm.com>
Reply-To: tom_gall@vnet.ibm.com
Organization: IBM
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.2.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: PATCH: New iSeries Device Drivers (small update)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

  Please Apply.

  I've updated the patch that I had posted on Monday so it applies against
2.4.4-ac15, with -p1. 

  Rather than spam the list the patch is at 
ftp://ftp.kernel.org/pub/linux/kernel/people/tgall/patch-lpar-dev-vs-2.4.4-ac15.gz

  The major / minor numbers in the patch were approved by hpa before the freeze
so hopefully there isn't an issue with these drivers going in on that account.

  Thanks!
  
  Tom
-- 
Tom Gall - PPC64                 "Where's the ka-boom? There was
Linux Technology Center           supposed to be an earth
(w) tom_gall@vnet.ibm.com         shattering ka-boom!"
(w) 507-253-4558                 -- Marvin Martian
(h) tgall@rochcivictheatre.org
http://www.ibm.com/linux/ltc/projects/ppc
