Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265943AbUJHXHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265943AbUJHXHN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 19:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265970AbUJHXHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 19:07:13 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:52966 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265943AbUJHXHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 19:07:12 -0400
Subject: Re: [PATCH] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Jody McIntyre <realtime-lsm@modernduck.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de,
       "Jack O'Quin" <joq@io.com>
In-Reply-To: <20041008152430.R2357@build.pdx.osdl.net>
References: <1096669179.27818.29.camel@krustophenia.net>
	 <20041001152746.L1924@build.pdx.osdl.net> <877jq5vhcw.fsf@sulphur.joq.us>
	 <1097193102.9372.25.camel@krustophenia.net>
	 <1097269108.1442.53.camel@krustophenia.net>
	 <20041008144539.K2357@build.pdx.osdl.net>
	 <1097272140.1442.75.camel@krustophenia.net>
	 <20041008145252.M2357@build.pdx.osdl.net>
	 <1097273105.1442.78.camel@krustophenia.net>
	 <20041008151911.Q2357@build.pdx.osdl.net>
	 <20041008152430.R2357@build.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1097276726.1442.82.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 08 Oct 2004 19:05:31 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 18:24, Chris Wright wrote:
> (relative to last one)
> 
> use in_group_p
> 

Thanks!  These make the patch even smaller and more comprehensible. 
Does this cover all the issues with the patch as I posted it?

Lee

