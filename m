Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263534AbREYFKA>; Fri, 25 May 2001 01:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263535AbREYFJu>; Fri, 25 May 2001 01:09:50 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:56508 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263534AbREYFJm>;
	Fri, 25 May 2001 01:09:42 -0400
Message-ID: <3B0DE906.7AB3107C@mandrakesoft.com>
Date: Fri, 25 May 2001 01:09:26 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch for PM in ymfpci (against 2.4.5-pre3)
In-Reply-To: <20010525002936.A27051@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks ok, only a small nit:  an include and 'pmdev' are left over from
the older PM implementation, and can be removed.
-- 
Jeff Garzik      | "Are you the police?"
Building 1024    | "No, ma'am.  We're musicians."
MandrakeSoft     |
