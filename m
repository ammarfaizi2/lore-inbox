Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262492AbTDAMnW>; Tue, 1 Apr 2003 07:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262495AbTDAMnW>; Tue, 1 Apr 2003 07:43:22 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:59113 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S262492AbTDAMnV>;
	Tue, 1 Apr 2003 07:43:21 -0500
Date: Tue, 1 Apr 2003 14:54:44 +0200
To: linux-kernel@vger.kernel.org
Subject: SCSI target mode
Message-ID: <20030401125444.GB19219@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Zdenek Kabelac <kabi@informatics.muni.cz>
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm looking for some SCSI target mode solution.
I've Adaptec aic7899 chip (Adaptec 3960D Ultra160 SCSI adapter)

I'd like to build virtual disc device - I've checked a lot
of pages via google, but I've not found anything which would have
mention usable solution for Target Mode.

I'd like to know if there is anyone who have succeded with this ?

Inside aic7xxx there is a define AHC_TARGET_MODE - but it
doesn't seem to be usable by linux for this moment.
Is there anyone working on this ?

PS: please Cc: me.

-- 
  .''`.
 : :' :    Zdenek Kabelac  kabi@{debian.org, users.sf.net, fi.muni.cz}
 `. `'           Debian GNU/Linux maintainer - www.debian.{org,cz}
   `-
