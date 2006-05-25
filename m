Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030483AbWEYWZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030483AbWEYWZs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 18:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030486AbWEYWZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 18:25:48 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:4231 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030483AbWEYWZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 18:25:47 -0400
Subject: Re: How to check if kernel sources are installed on a system?
From: Lee Revell <rlrevell@joe-job.com>
To: 4Front Technologies <dev@opensound.com>
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-kernel@vger.kernel.org
In-Reply-To: <44762C6A.9090003@opensound.com>
References: <e55715+usls@eGroups.com>  <20060525212942.GS13513@lug-owl.de>
	 <1148594527.31038.22.camel@mindpipe>  <44762C6A.9090003@opensound.com>
Content-Type: text/plain
Date: Thu, 25 May 2006 18:25:43 -0400
Message-Id: <1148595944.31038.28.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-25 at 15:15 -0700, 4Front Technologies wrote:
> It doesn't matter if it's open sound or ALSA!. Lee, why don't you go
> down the ALSA user mailing lists and count the number of 0-Compilation
> bug reports? 

I know - I am on all the ALSA lists and read every bug report.  And in
fact compilation errors are quite rare.  The numbers are misleading
because "0-Compilation error" is the default category in the bug tracker
and lots of users don't set it correctly ;-)

It is unfortunate that users hitting an already-fixed bug have to
compile it themselves, but I think the solution is for the distros to
follow ALSA a bit more closely and apply the critical "no sound" fixes
to their packages rather than waiting for the next release.  I know for
a fact that Ubuntu does this.

Lee

