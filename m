Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131434AbRAWWFc>; Tue, 23 Jan 2001 17:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131415AbRAWWFX>; Tue, 23 Jan 2001 17:05:23 -0500
Received: from ha1.rdc2.nsw.optushome.com.au ([203.164.2.50]:13006 "EHLO
	mss.rdc2.nsw.optushome.com.au") by vger.kernel.org with ESMTP
	id <S131434AbRAWWFI>; Tue, 23 Jan 2001 17:05:08 -0500
Message-ID: <3A6DFF3D.2841ADD5@optushome.com.au>
Date: Wed, 24 Jan 2001 09:01:33 +1100
From: Glenn McGrath <bug1@optushome.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Clausen <clausen@conectiva.com.br>
CC: Bryan Henderson <hbryan@us.ibm.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, bug-parted@gnu.org
Subject: Re: Partition IDs in the New World TM
In-Reply-To: <OF5F9BE7DB.C1ADFB0E-ON872569DD.006485CC@LocalDomain> <3A6DCEEC.66B15F3F@conectiva.com.br>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Clausen wrote:
> 
> Bryan Henderson wrote:
> > Incidentally, I just realized that the common name "partition ID"
> > for this value is quite a misnomer.  As far as I know, it has
> > never identified the partition, but rather described its contents.
> 
> Yes, "partition type ID" is better.
> 

Why not call it filesystem id, thats what its usually describing

Glenn
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
