Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291162AbSBYKRI>; Mon, 25 Feb 2002 05:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293366AbSBYKQ6>; Mon, 25 Feb 2002 05:16:58 -0500
Received: from pop.univ-lyon1.fr ([134.214.100.7]:530 "HELO pop.univ-lyon1.fr")
	by vger.kernel.org with SMTP id <S291162AbSBYKQt>;
	Mon, 25 Feb 2002 05:16:49 -0500
Date: Mon, 25 Feb 2002 11:16:24 +0100
From: Fabrice Bellet <Fabrice.Bellet@creatis.insa-lyon.fr>
To: Steven Walter <srwalter@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
Message-ID: <20020225111624.A6835@creatis.insa-lyon.fr>
Reply-To: Fabrice Bellet <Fabrice.Bellet@creatis.insa-lyon.fr>
In-Reply-To: <20020224212727.A15097@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020224212727.A15097@hapablap.dyn.dhs.org>; from srwalter@yahoo.com on Sun, Feb 24, 2002 at 09:27:27PM -0600
X-Operating-System: Linux bonobo 2.4.18-pre9-mjc2
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2002 at 09:27:27PM -0600, Steven Walter wrote:
> After unintentionally deleting some file, I noticed what appears to be
> an incosistency (or at least a change) in ext3.  Running debugfs and
> executing the command "lsdel", I saw no inodes listed since I last ran
> the partition as ext2.  Does ext3 not add its deleted inodes to whatever
> list ext2 does?  And can this be fixed without compromising the speed or
> data-integrity of ext3?

This issue has been discussed in the ext3-users mailing few monthes ago:

https://listman.redhat.com/pipermail/ext3-users/2001-March/000381.html

and more recently :

https://listman.redhat.com/pipermail/ext3-users/2002-February/002950.html

-- 
fabrice

