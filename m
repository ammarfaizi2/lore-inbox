Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129759AbRAWSft>; Tue, 23 Jan 2001 13:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129763AbRAWSfa>; Tue, 23 Jan 2001 13:35:30 -0500
Received: from postfix.conectiva.com.br ([200.250.58.155]:35857 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S129759AbRAWSf0>; Tue, 23 Jan 2001 13:35:26 -0500
Message-ID: <3A6DCEEC.66B15F3F@conectiva.com.br>
Date: Tue, 23 Jan 2001 16:35:24 -0200
From: Andrew Clausen <clausen@conectiva.com.br>
Organization: Conectiva
X-Mailer: Mozilla 4.76 [pt_BR] (X11; U; Linux 2.2.17-14cl i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Bryan Henderson <hbryan@us.ibm.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        bug-parted@gnu.org
Subject: Re: Partition IDs in the New World TM
In-Reply-To: <OF5F9BE7DB.C1ADFB0E-ON872569DD.006485CC@LocalDomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan Henderson wrote:
> Allow me to reword to what you probably meant:  Have a partition
> ID that means "generic partition - check signatures within for
> details."  (And then get people who develop file systems for use
> with Linux, at least, to have a policy of always using that).

OK.

> Incidentally, I just realized that the common name "partition ID"
> for this value is quite a misnomer.  As far as I know, it has
> never identified the partition, but rather described its contents.

Yes, "partition type ID" is better.

Andrew Clausen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
