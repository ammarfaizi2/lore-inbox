Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbSI2XLL>; Sun, 29 Sep 2002 19:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261875AbSI2XLL>; Sun, 29 Sep 2002 19:11:11 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:62355 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261874AbSI2XLK>;
	Sun, 29 Sep 2002 19:11:10 -0400
Date: Mon, 30 Sep 2002 00:19:55 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Phil Oester <kernel@theoesters.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.39 - make MCE options arch dependent
Message-ID: <20020929231955.GA20073@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Phil Oester <kernel@theoesters.com>, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
References: <20020929161206.A14962@ns1.theoesters.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020929161206.A14962@ns1.theoesters.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2002 at 04:12:06PM -0700, Phil Oester wrote:
 > No need to see P4 or Athlon options if you don't have one...
 > 
 > -Phil

Broken. Vendor kernels compile for 386, but include both these
options, so the same kernel can run on P4/Athlon and use
these options.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
