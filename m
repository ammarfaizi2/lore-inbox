Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316751AbSERFo5>; Sat, 18 May 2002 01:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316750AbSERFo4>; Sat, 18 May 2002 01:44:56 -0400
Received: from dsl-213-023-043-065.arcor-ip.net ([213.23.43.65]:27018 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316753AbSERFoz>;
	Sat, 18 May 2002 01:44:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andreas Dilger <adilger@clusterfs.com>
Subject: Re: Htree directory index for Ext2, updated
Date: Sat, 18 May 2002 07:44:36 +0200
X-Mailer: KMail [version 1.3.2]
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <200205170736.g4H7aNj281162@saturn.cs.uml.edu> <E178suL-0000Bs-00@starship> <20020518053458.GF21295@turbolinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E178x1B-0000DW-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 May 2002 07:34, Andreas Dilger wrote:
> On May 18, 2002  03:21 +0200, Daniel Phillips wrote:
> > Patch is severely broken in its current form, not only for the
> > reasons you stated, but also because of its inability to handle
> > renaming in any sane way.  I want a patch --sane option.
> 
> I bet BitKeeper gets it right... ;-) ;-) ;-)

Funny you should mention that, since Bitkeeper has embarrassed itself pretty
badly with respect to patches, so far.

  - Somebody decided to add another level on top of the linux root directory
    in their source directory.  I can't import patches into that.

  - I can apply patches to bitkeeper repository using the normal 'patch',
    but Bitkeeper gets its revenge later, as each bk edit command starts
    off by throwing away the patch.

Given the hype, I expected more.  I want a tool to save work for me, not
create new work.  I don't think I'll be using Bitkeeper as a substitute for
patch any time soon.

-- 
Daniel
