Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277732AbRJLPgf>; Fri, 12 Oct 2001 11:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277733AbRJLPg1>; Fri, 12 Oct 2001 11:36:27 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:38322
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S277732AbRJLPgQ>; Fri, 12 Oct 2001 11:36:16 -0400
Date: Fri, 12 Oct 2001 08:36:16 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: reiserfs-list <reiserfs-list@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.12-ac1
Message-ID: <20011012083616.C9992@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20011012072910.N21564@cpe-24-221-152-185.az.sprintbbd.net> <E15s44B-0007Vk-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15s44B-0007Vk-00@the-village.bc.nu>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2001 at 04:17:39PM +0100, Alan Cox wrote:
> > On Fri, Oct 12, 2001 at 02:17:26PM +0100, Alan Cox wrote:
> > 
> > > 2.4.12-ac1
> > > o	Merge the majority of 2.4.11/12
> > > 	-	Fall back to the Linus reiserfs code set
> > [snip]
> > 
> > The endian-safe patches will come back tho, right?  I don't think those
> > have made it into Linus' tree yet...
> 
> Really what needs to happen is the important bits that were tested and
> the reiser folks were happy with get pushed back bit by bit into both trees
> now
[reiserfs list added to cc]

That would be nice.  Are there any plans on behalf of the reiserfs
people to merge in the Endian-Safeness patches now?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
