Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267195AbUJBAzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267195AbUJBAzY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 20:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266912AbUJBAyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 20:54:05 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:52383 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267180AbUJBAxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 20:53:08 -0400
Subject: Re: [Alsa-devel] alsa-driver will not compile with kernel
	2.6.9-rc2-mm4-S7
From: Lee Revell <rlrevell@joe-job.com>
To: Tonnerre <tonnerre@thundrix.ch>
Cc: Rui Nuno Capela <rncbc@rncbc.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20041002004854.GB26711@thundrix.ch>
References: <1096675930.27818.74.camel@krustophenia.net>
	 <32868.192.168.1.8.1096677269.squirrel@192.168.1.8>
	 <20041002004854.GB26711@thundrix.ch>
Content-Type: text/plain
Message-Id: <1096678383.27818.87.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 01 Oct 2004 20:53:04 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-01 at 20:48, Tonnerre wrote:
> Salut,
> 
> On Sat, Oct 02, 2004 at 01:34:29AM +0100, Rui Nuno Capela wrote:
> > Maybe someone on the lkml may have a clue and help here?
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=109526630905797&w=2

Thanks, but it's already obvious that this is related to the iomem
changes.  This does not address this issue of what specifically broke
ALSA between -mm3 and -mm4.

If it is clear to you what the issue is then a patch would be much more
helpful ;-)

Lee

