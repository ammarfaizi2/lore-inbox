Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129571AbQLAUS6>; Fri, 1 Dec 2000 15:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129663AbQLAUSt>; Fri, 1 Dec 2000 15:18:49 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:33033 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129571AbQLAUSl>; Fri, 1 Dec 2000 15:18:41 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Roberto Ragusa <robertoragusa@technologist.com>
Date: Sat, 2 Dec 2000 06:47:41 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14888.93.991512.725794@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel panic in SoftwareRAID autodetection
In-Reply-To: message from Roberto Ragusa on Friday December 1
In-Reply-To: <yam8370.2457.159377448@a4000>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday December 1, robertoragusa@technologist.com wrote:
> Please CC to me because I'm not a LKML subscriber.
> 
> Hi,
> 
> I found a real showstopper problem in the SoftwareRAID autodetect
> code; 2.4.0-test10 and 2.4.0-test11 are affected (I didn't test
> previous versions).

Fixed in 2.4.0-test12pre3.  
If you are a raid users, it might be worth while subscribing to
linux-raid@vger.kernel.org.   Then you probably would have known
already....

NeilBrown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
