Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278121AbRJLUai>; Fri, 12 Oct 2001 16:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278120AbRJLUa2>; Fri, 12 Oct 2001 16:30:28 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:41223 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S278119AbRJLUaL>; Fri, 12 Oct 2001 16:30:11 -0400
Message-ID: <3BC752E9.171FB08E@namesys.com>
Date: Sat, 13 Oct 2001 00:30:33 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: tom_gall@vnet.ibm.com
CC: Tom Rini <trini@kernel.crashing.org>, reiserfs-list@namesys.com,
        linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] Re: Linux 2.4.12-ac1
In-Reply-To: <20011012072910.N21564@cpe-24-221-152-185.az.sprintbbd.net> <E15s44B-0007Vk-00@the-village.bc.nu> <20011012083616.C9992@cpe-24-221-152-185.az.sprintbbd.net> <3BC71084.ECCD2E4B@vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Gall wrote:
> 
> Tom Rini wrote:
> >
> > On Fri, Oct 12, 2001 at 04:17:39PM +0100, Alan Cox wrote:
> > > > On Fri, Oct 12, 2001 at 02:17:26PM +0100, Alan Cox wrote:
> > > >
> > > > > 2.4.12-ac1
> > > > > o Merge the majority of 2.4.11/12
> > > > >   -       Fall back to the Linus reiserfs code set
> > > > [snip]
> > > >
> > > > The endian-safe patches will come back tho, right?  I don't think those
> > > > have made it into Linus' tree yet...
> > >
> > > Really what needs to happen is the important bits that were tested and
> > > the reiser folks were happy with get pushed back bit by bit into both trees
> > > now
> > [reiserfs list added to cc]
> >
> > That would be nice.  Are there any plans on behalf of the reiserfs
> > people to merge in the Endian-Safeness patches now?
> 
> Speaking from the PPC64 crew, this would be highly desirable.
> 
> Regards,
> 
> Tom
> 
> --
> Tom Gall - PPC64 Code Monkey     "Where's the ka-boom? There was
> Linux Technology Center           supposed to be an earth
> (w) tom_gall@vnet.ibm.com         shattering ka-boom!"
> (w) 507-253-4558                 -- Marvin Martian
> (h) tgall@rochcivictheatre.org
> http://www.ibm.com/linux/ltc/projects/ppc

Patch has been sent to Linus.  It will be resent to him and ac now that a new
release has come out.

Hans
