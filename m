Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279589AbRJXUmx>; Wed, 24 Oct 2001 16:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279593AbRJXUmd>; Wed, 24 Oct 2001 16:42:33 -0400
Received: from patan.Sun.COM ([192.18.98.43]:23190 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S279589AbRJXUm0>;
	Wed, 24 Oct 2001 16:42:26 -0400
Message-ID: <3BD72A8A.F4EB4188@sun.com>
Date: Wed, 24 Oct 2001 13:54:34 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12C5_V i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Ford <david@blue-labs.org>
CC: Christopher Friesen <cfriesen@nortelnetworks.com>, kuznet@ms2.inr.ac.ru,
        Julian Anastasov <ja@ssi.bg>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: issue: deleting one IP alias deletes all
In-Reply-To: <Pine.LNX.4.33.0110240042570.1210-100000@u.domain.uli> <3BD65188.1060203@blue-labs.org> <3BD6CA13.613B22EE@nortelnetworks.com> <3BD7263A.9020100@blue-labs.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ford wrote:
> 
> That is IMO bad behavior, it didn't use to do this because I have
> scripts that rely on this behavior.
> 
> I'll take it up with the author, Alexey.

It has done this since 2.2.x, when we first filed and fixed this bug.  I've
pinged Alexey, and haven't heard back yet.  Maybe you'll have better
response time.

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
