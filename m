Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269462AbRHCQSA>; Fri, 3 Aug 2001 12:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269456AbRHCQRo>; Fri, 3 Aug 2001 12:17:44 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:30983 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S269455AbRHCQRH>; Fri, 3 Aug 2001 12:17:07 -0400
From: Nikita Danilov <NikitaDanilov@Yahoo.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15210.52816.115745.389614@beta.namesys.com>
Date: Fri, 3 Aug 2001 20:16:16 +0400
To: jlnance@intrex.net
Cc: Nikita Danilov <NikitaDanilov@Yahoo.COM>, linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-dev] Re: [PATCH]: reiserfs: D-clear-i_blocks.patch
In-Reply-To: <20010803085306.A1248@bessie.localdomain>
In-Reply-To: <15209.30134.699801.417492@beta.namesys.com>
	<200108021726.f72HQrMh027270@webber.adilger.int>
	<15209.40051.124575.787738@beta.namesys.com>
	<20010803085306.A1248@bessie.localdomain>
X-Mailer: VM 6.89 under 21.1 (patch 8) "Bryce Canyon" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jlnance@intrex.net writes:
 > On Thu, Aug 02, 2001 at 10:31:15PM +0400, Nikita Danilov wrote:
 > > Andreas Dilger writes:
 > >  > PS - could someone on the reiserfs team (or Linus) run the reiserfs code
 > >  >      through "indent" (or auto format in emacs) per
 > >  >      Documentation/CodingStyle?  It is really a gross mess, to such a
 > >  >      point that you can hardly see what
 > > 
 > > Oh, yes.
 > > 
 > >  >      is going on.  It's not just that it is a different indent style, it
 > >  >      has no coherent indentation or comment formatting at all.  Maybe
 > >  >      for 2.5?
 > > 
 > > I hope so. We already have 200k of cleanup patches in 2.4.7-ac3.
 > 
 > >From past experience, if you want to run the code through indent, I would
 > recomend that you submit patches for that which contain no other changes.
 > If you mix indent changes with code changes, it gets very difficult to
 > see what was actually changed if bugs crop up.

Thank you. Do you have an experience in or opinion on asking Linus to
perform such conversion himself, because this will probably save some
trouble?

 > 
 > Thanks,
 > 
 > Jim

[lkml: please CC me, I am not subscribed.]

Nikita.
