Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbVKXTBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbVKXTBQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 14:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbVKXTBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 14:01:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5043 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751384AbVKXTBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 14:01:15 -0500
Date: Thu, 24 Nov 2005 13:59:39 -0500
From: Dave Jones <davej@redhat.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Hugh Dickins <hugh@veritas.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Con Kolivas <con@kolivas.org>, Kenneth W <kenneth.w.chen@intel.com>,
       Keith Owens <kaos@sgi.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG at mm/rmap.c:491
Message-ID: <20051124185939.GD4638@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Lee Revell <rlrevell@joe-job.com>, Hugh Dickins <hugh@veritas.com>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	Con Kolivas <con@kolivas.org>, Kenneth W <kenneth.w.chen@intel.com>,
	Keith Owens <kaos@sgi.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
References: <200511232256.jANMuGg20547@unix-os.sc.intel.com> <cone.1132788250.534735.25446.501@kolivas.org> <200511232335.15050.s0348365@sms.ed.ac.uk> <20051124044009.GE30849@redhat.com> <Pine.LNX.4.61.0511240747590.5688@goblin.wat.veritas.com> <1132831993.3473.20.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132831993.3473.20.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2005 at 06:33:12AM -0500, Lee Revell wrote:
 > On Thu, 2005-11-24 at 07:50 +0000, Hugh Dickins wrote:
 > > But I've CC'ed Keith,
 > > we sometimes find the kernel does things so to suit ksymoops. 
 > 
 > Um, unless someone has been merging Documentation patches without
 > reading them, ksymoops shouldn't be used with 2.6 anyway.

It is occasionally still useful for decoding Code: lines back
to assembly.

		Dave

