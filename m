Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129325AbQLAPMm>; Fri, 1 Dec 2000 10:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129520AbQLAPMd>; Fri, 1 Dec 2000 10:12:33 -0500
Received: from smtprch2.nortelnetworks.com ([192.135.215.15]:59524 "EHLO
	smtprch2.nortel.com") by vger.kernel.org with ESMTP
	id <S129325AbQLAPMV>; Fri, 1 Dec 2000 10:12:21 -0500
Message-ID: <3A27B513.683EF511@nortelnetworks.com>
Date: Fri, 01 Dec 2000 09:26:27 -0500
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.7 [en] (X11; U; HP-UX B.10.20 9000/778)
X-Accept-Language: en
MIME-Version: 1.0
To: Dries van Oosten <D.vanOosten@phys.uu.nl>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 routing problem
In-Reply-To: <Pine.OSF.4.30.0012011020410.15665-100000@ruunat.phys.uu.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
X-Orig: <cfriesen@americasm01.nt.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dries van Oosten wrote:
> 
> On Fri, 1 Dec 2000, Dax Kelson wrote:

> > If you want to take full advantage of all the networking features, you
> > need to use iproute2.
> >
> > ftp://ftp.inr.ac.ru/ip-routing/iproute2-2.2.4-now-ss??????.tar.gz
> 
> I downloaded and compiled them and they don't work as well.
> What am I missing here?

Try recompiling the kernel with "advanced routing" "policy routing" and
"netlink" turned on.

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
