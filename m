Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269930AbUJGX6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269930AbUJGX6d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 19:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269945AbUJGXz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 19:55:29 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:6061 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269930AbUJGXvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 19:51:48 -0400
Subject: Re: [PATCH] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Wright <chrisw@osdl.org>,
       Jody McIntyre <realtime-lsm@modernduck.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de,
       "Jack O'Quin" <joq@io.com>
In-Reply-To: <877jq5vhcw.fsf@sulphur.joq.us>
References: <1094967978.1306.401.camel@krustophenia.net>
	 <20040920202349.GI4273@conscoop.ottawa.on.ca>
	 <20040930211408.GE4273@conscoop.ottawa.on.ca>
	 <1096581213.24868.19.camel@krustophenia.net>
	 <87pt43clzh.fsf@sulphur.joq.us> <20040930182053.B1973@build.pdx.osdl.net>
	 <87k6ubcccl.fsf@sulphur.joq.us>
	 <1096663225.27818.12.camel@krustophenia.net>
	 <20041001142259.I1924@build.pdx.osdl.net>
	 <1096669179.27818.29.camel@krustophenia.net>
	 <20041001152746.L1924@build.pdx.osdl.net>  <877jq5vhcw.fsf@sulphur.joq.us>
Content-Type: text/plain
Message-Id: <1097193102.9372.25.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 07 Oct 2004 19:51:42 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-05 at 01:55, Jack O'Quin wrote:
> Thanks to the good work being done on 2.6, we are now close to being
> able to do serious realtime work with standard kernels available
> everwhere.  The LSM framework is an important element of that
> solution, with the realtime LSM a small but essential component,
> because it makes these features available without excessive
> administrative burden.

Since no one has objected to any of Jack's points, and now that the
setpcap is gone, and with more audio users moving to 2.6+mm+VP every
day, I would like to ask that this go into -mm.  Any objections?

Lee

