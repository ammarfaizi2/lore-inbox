Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289212AbSA2NNm>; Tue, 29 Jan 2002 08:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288845AbSA2NNd>; Tue, 29 Jan 2002 08:13:33 -0500
Received: from rgminet2.oracle.com ([148.87.122.31]:38621 "EHLO
	rgminet2.oracle.com") by vger.kernel.org with ESMTP
	id <S288810AbSA2NNU>; Tue, 29 Jan 2002 08:13:20 -0500
Message-ID: <3C56A031.A2D205B9@oracle.com>
Date: Tue, 29 Jan 2002 14:14:25 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.3-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
        John Levon <movement@marcelothewonderpenguin.com>,
        linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: [PATCH] Fix 2.5.3pre reiserfs BUG() at boot time
In-Reply-To: <20020125180149.GB45738@compsoc.man.ac.uk> <Pine.LNX.4.33.0201251006220.1632-100000@penguin.transmeta.com> <20020125204911.A17190@wotan.suse.de> <20020125133814.U763@lynx.adilger.int> <20020125231555.A22583@wotan.suse.de> <3C54871E.80621B4E@oracle.com> <20020128010142.A23952@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> On Mon, Jan 28, 2002 at 12:02:54AM +0100, Alessandro Suardi wrote:
> >
> > 2.5.3-pre5 + this patch still can't boot my system. I haven't had
> >  time to copy down oops at boot, will do if needed.
> 
> Please do. I cannot see anything in the patch that should prevent bootup
> though, so I would also recommend a make clean and recompile first just
> to make sure it isn't a broken build.

I ended up away from email for a couple of days and saw -pre6;
 re-patched from 2.5.2 to -pre6, boot is okay .

Thanks & ciao,

--alessandro

 "this machine will, will not communicate
   these thoughts and the strain I am under
  be a world child, form a circle before we all go under"
                         (Radiohead, "Street Spirit [fade out]")
