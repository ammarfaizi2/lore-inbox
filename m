Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129325AbQLOKDP>; Fri, 15 Dec 2000 05:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129345AbQLOKDF>; Fri, 15 Dec 2000 05:03:05 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:1800 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S129325AbQLOKDB>;
	Fri, 15 Dec 2000 05:03:01 -0500
Date: Fri, 15 Dec 2000 01:32:31 -0800 (PST)
From: Chris Mason <mason@suse.com>
To: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 + reiserfs + smp
In-Reply-To: <Pine.LNX.4.30.0012150122580.5633-100000@playtoy.hislinuxbox.com>
Message-ID: <Pine.LNX.4.10.10012150131280.31093-100000@home.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Dec 2000, David D.W. Downey wrote:
> 
> I've been reading the thread regarding data corruption with 2.4.0-test12,
> reiserfs, and smp.
> 
> Unfrotunately I've not seen any resolution announced about this. Is this
> still an issue or has this been fixed?
> 
reiserfs and test12 won't play nice at all right now due to the
ll_rw_block changes.  I'm testing a patch now, it should be done sometime
today.

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
