Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130793AbRCJMhC>; Sat, 10 Mar 2001 07:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130835AbRCJMgx>; Sat, 10 Mar 2001 07:36:53 -0500
Received: from zeus.kernel.org ([209.10.41.242]:51395 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130793AbRCJMgn>;
	Sat, 10 Mar 2001 07:36:43 -0500
Date: 10 Mar 2001 13:22:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <7xaONpZHw-B@khms.westfalen.de>
In-Reply-To: <3A959BFD.B18F833@netcomuk.co.uk>
Subject: Re: Hashing and directories
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <3A959BFD.B18F833@netcomuk.co.uk>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

billc@netcomuk.co.uk (Bill Crawford)  wrote on 22.02.01 in <3A959BFD.B18F833@netcomuk.co.uk>:

>  A particular reason for this, apart from filesystem efficiency,
> is to make it easier for people to find things, as it is usually
> easier to spot what you want amongst a hundred things than among
> a thousand or ten thousand.
>
>  A couple of practical examples from work here at Netcom UK (now
> Ebone :), would be say DNS zone files or user authentication data.
> We use Solaris and NFS a lot, too, so large directories are a bad
> thing in general for us, so we tend to subdivide things using a
> very simple scheme: taking the first letter and then sometimes
> the second letter or a pair of letters from the filename.  This
> actually works extremely well in practice, and as mentioned above
> provides some positive side-effects.

So the practical difference between finding a file in a hierarchy if you  
already know the first N characters (because you need them to find the  
subdirectory it's in), and finding the same file in a flat directory still  
knowing the first N characters, is ... well, maybe tab completion is a tad  
slower.

Sorry, but I can't see the human angle.


MfG Kai
