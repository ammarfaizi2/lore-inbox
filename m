Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161036AbVKXMNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161036AbVKXMNY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 07:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161034AbVKXMNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 07:13:24 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:28060 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161033AbVKXMNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 07:13:22 -0500
Subject: Re: Kernel BUG at mm/rmap.c:491
From: Lee Revell <rlrevell@joe-job.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Dave Jones <davej@redhat.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Con Kolivas <con@kolivas.org>, Kenneth W <kenneth.w.chen@intel.com>,
       Keith Owens <kaos@sgi.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0511240747590.5688@goblin.wat.veritas.com>
References: <200511232256.jANMuGg20547@unix-os.sc.intel.com>
	 <cone.1132788250.534735.25446.501@kolivas.org>
	 <200511232335.15050.s0348365@sms.ed.ac.uk>
	 <20051124044009.GE30849@redhat.com>
	 <Pine.LNX.4.61.0511240747590.5688@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Thu, 24 Nov 2005 06:33:12 -0500
Message-Id: <1132831993.3473.20.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-24 at 07:50 +0000, Hugh Dickins wrote:
> But I've CC'ed Keith,
> we sometimes find the kernel does things so to suit ksymoops. 

Um, unless someone has been merging Documentation patches without
reading them, ksymoops shouldn't be used with 2.6 anyway.

Lee

