Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316585AbSFDTNB>; Tue, 4 Jun 2002 15:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316587AbSFDTNA>; Tue, 4 Jun 2002 15:13:00 -0400
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:59894 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S316585AbSFDTM7>;
	Tue, 4 Jun 2002 15:12:59 -0400
Date: Tue, 4 Jun 2002 15:12:57 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Brett Dikeman <brett@cloud9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 assertion failure in journal_commit_transaction
Message-ID: <20020604191257.GA24463@www.kroptech.com>
In-Reply-To: <a05111705b922b09b689a@[10.1.0.123]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2002 at 02:30:07PM -0400, Brett Dikeman wrote:
> Greetings all.
> 
> I'm helping a company which just installed Redhat 7.3 on several 
> systems(Compaq dl380G2, dual proc systems.)  They are running the smp 
> kernel that came with the distro(versioned 2.4.18-3; -4 is out, but I 
> reviewed the changelogs and it didn't look like they did anything 
> that would affect this problem, but I really couldn't tell.)  ext3 
> for all filesystems, hardware raid 0+1 via the Compaq controller.

Uh, what changelog did you read?

Redhat seems pretty clear that 2.4.18-3 + ext3 + SMP = bad

The errata describing 2.4.18-4 is here:
http://rhn.redhat.com/errata/RHBA-2002-085.html

--Adam

