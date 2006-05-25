Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030500AbWEYWk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030500AbWEYWk2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 18:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030497AbWEYWk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 18:40:28 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:3465 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030500AbWEYWk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 18:40:27 -0400
Subject: Re: How to check if kernel sources are installed on a system?
From: Lee Revell <rlrevell@joe-job.com>
To: Dave Jones <davej@redhat.com>
Cc: 4Front Technologies <dev@opensound.com>,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20060525223449.GG4328@redhat.com>
References: <e55715+usls@eGroups.com> <20060525212942.GS13513@lug-owl.de>
	 <1148594527.31038.22.camel@mindpipe> <44762C6A.9090003@opensound.com>
	 <1148595944.31038.28.camel@mindpipe>  <20060525223449.GG4328@redhat.com>
Content-Type: text/plain
Date: Thu, 25 May 2006 18:40:23 -0400
Message-Id: <1148596824.31038.33.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-25 at 18:34 -0400, Dave Jones wrote:
> The answer is not "push more patches to distros" the answer is
> "subsystems need to push more fixes to -stable when bugs are fixed
>  instead of sitting on them in private SCMs for 2 months waiting
>  for the next merge window". 

ALSA recently moved from sourceforge CVS to a Mercurial repository which
should make this easier in the future.

Lee 

