Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131737AbRAXNlW>; Wed, 24 Jan 2001 08:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132105AbRAXNlM>; Wed, 24 Jan 2001 08:41:12 -0500
Received: from postfix.conectiva.com.br ([200.250.58.155]:56079 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131737AbRAXNlE>; Wed, 24 Jan 2001 08:41:04 -0500
Message-ID: <3A6EDB56.4417D634@conectiva.com.br>
Date: Wed, 24 Jan 2001 11:40:38 -0200
From: Andrew Clausen <clausen@conectiva.com.br>
Organization: Conectiva
X-Mailer: Mozilla 4.76 [pt_BR] (X11; U; Linux 2.2.17-14cl i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Glenn McGrath <bug1@optushome.com.au>
Cc: Bryan Henderson <hbryan@us.ibm.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, bug-parted@gnu.org
Subject: Re: Partition IDs in the New World TM
In-Reply-To: <OF5F9BE7DB.C1ADFB0E-ON872569DD.006485CC@LocalDomain> <3A6DCEEC.66B15F3F@conectiva.com.br> <3A6DFF3D.2841ADD5@optushome.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Glenn McGrath wrote:
> 
> Andrew Clausen wrote:
> >
> > Bryan Henderson wrote:
> > > Incidentally, I just realized that the common name "partition ID"
> > > for this value is quite a misnomer.  As far as I know, it has
> > > never identified the partition, but rather described its contents.
> >
> > Yes, "partition type ID" is better.
> >
> 
> Why not call it filesystem id, thats what its usually describing

Not true.  It may be describing LVM, RAID, or
save-ram-to-disk-for-fast-restart

Andrew Clausen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
