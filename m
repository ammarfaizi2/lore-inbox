Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262303AbSKUUff>; Thu, 21 Nov 2002 15:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264739AbSKUUff>; Thu, 21 Nov 2002 15:35:35 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:18326 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262303AbSKUUfe>;
	Thu, 21 Nov 2002 15:35:34 -0500
Date: Thu, 21 Nov 2002 20:40:56 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Margit Schubert-While <margitsw@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: P4 compile options
Message-ID: <20021121204056.GA19455@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Margit Schubert-While <margitsw@t-online.de>,
	linux-kernel@vger.kernel.org
References: <4.3.2.7.2.20021121210830.00b58890@mail.dns-host.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4.3.2.7.2.20021121210830.00b58890@mail.dns-host.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 09:18:30PM +0100, Margit Schubert-While wrote:
 > Maybe a dumb question -
 > Is it possible to use the "-march=pentium4 -mfpmath=sse -msse2" options
 > for a P4 ?
 > I notice anything over a P2 just gets "-march=i686".

This is already done in 2.5. (Well, the -march anyways)

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
