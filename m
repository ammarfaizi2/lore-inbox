Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265234AbUJHV1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265234AbUJHV1S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 17:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265331AbUJHV1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 17:27:18 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:19162 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265234AbUJHV1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 17:27:16 -0400
Subject: Re: [PATCH] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: chrisw@osdl.org, realtime-lsm@modernduck.com,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de,
       "Jack O'Quin" <joq@io.com>
In-Reply-To: <20041008142121.328b8d3a.akpm@osdl.org>
References: <1094967978.1306.401.camel@krustophenia.net>
	 <20040920202349.GI4273@conscoop.ottawa.on.ca>
	 <20040930211408.GE4273@conscoop.ottawa.on.ca>
	 <1096581213.24868.19.camel@krustophenia.net>
	 <87pt43clzh.fsf@sulphur.joq.us> <20040930182053.B1973@build.pdx.osdl.net>
	 <87k6ubcccl.fsf@sulphur.joq.us>
	 <1096663225.27818.12.camel@krustophenia.net>
	 <20041001142259.I1924@build.pdx.osdl.net>
	 <1096669179.27818.29.camel@krustophenia.net>
	 <20041001152746.L1924@build.pdx.osdl.net> <877jq5vhcw.fsf@sulphur.joq.us>
	 <1097193102.9372.25.camel@krustophenia.net>
	 <1097269108.1442.53.camel@krustophenia.net>
	 <20041008142121.328b8d3a.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1097270754.1442.71.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 08 Oct 2004 17:25:54 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 17:21, Andrew Morton wrote:
> Lee Revell <rlrevell@joe-job.com> wrote:
> >
> > Here's an updated patch, only
> > difference is line numbers.
> 
> Nice patch.  Wanna tell me something about what it's for?
> 

Also, just to give a frame of reference, MacOS X (which is our real 
competition in the pro audio area) just lets any user run RT tasks.  So
this LSM would give us that needed functionality, but better, because
it's selective.

Lee

