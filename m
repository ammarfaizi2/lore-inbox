Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311737AbSCNTEC>; Thu, 14 Mar 2002 14:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311738AbSCNTDw>; Thu, 14 Mar 2002 14:03:52 -0500
Received: from zeus.kernel.org ([204.152.189.113]:50425 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S311737AbSCNTDk>;
	Thu, 14 Mar 2002 14:03:40 -0500
Date: Thu, 14 Mar 2002 19:58:35 +0100
From: Dave Jones <davej@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Martin Dalecki <martin@dalecki.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Actually hide x86 IDE chipsets on !CONFIG_X86
Message-ID: <20020314195835.A24996@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Tom Rini <trini@kernel.crashing.org>,
	Martin Dalecki <martin@dalecki.de>,
	LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20020314165018.GE706@opus.bloom.county> <20020314181106.J19636@suse.de> <20020314172402.GG706@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020314172402.GG706@opus.bloom.county>; from trini@kernel.crashing.org on Thu, Mar 14, 2002 at 10:24:02AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 10:24:02AM -0700, Tom Rini wrote:
 > >  I've a PCI card with one of these. It could in theory work on any arch
 > >  with a PCI slot.
 > A 640 and not a 646?

 Yup, though its too brain damaged to use.
 I believe they also appeared in some Alphas too.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
