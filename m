Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVENS1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVENS1y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 14:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVENS1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 14:27:54 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:17865 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261455AbVENS1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 14:27:52 -0400
Subject: Re: Hyper-Threading Vulnerability
From: Lee Revell <rlrevell@joe-job.com>
To: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <d65b2m$atq$1@sea.gmane.org>
References: <1115963481.1723.3.camel@alderaan.trey.hu>
	 <m164xnatpt.fsf@muc.de> <1116009483.4689.803.camel@rebel.corp.whenu.com>
	 <20050513190549.GB47131@muc.de> <20050513212620.GA12522@hexapodia.org>
	 <20050513215905.GY5914@waste.org>
	 <1116024419.20646.41.camel@localhost.localdomain>
	 <1116025212.6380.50.camel@mindpipe>  <20050513232708.GC13846@redhat.com>
	 <1116027488.6380.55.camel@mindpipe>
	 <1116084186.20545.47.camel@localhost.localdomain>
	 <1116088229.8880.7.camel@mindpipe>  <d65b2m$atq$1@sea.gmane.org>
Content-Type: text/plain
Date: Sat, 14 May 2005 14:27:51 -0400
Message-Id: <1116095271.9141.15.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-05-14 at 19:04 +0200, Jindrich Makovicka wrote:
> AFAIK, mplayer actually uses gettimeofday(). rdtsc is used in some
> places for profiling and debugging purposes and not compiled in by default.
> 

OK.  The comments in the JACK code say it was copied from mplayer.  I
guess the usage is not the same.

Lee

