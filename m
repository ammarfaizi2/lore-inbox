Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbVDNSCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVDNSCN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 14:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVDNSCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 14:02:12 -0400
Received: from colin2.muc.de ([193.149.48.15]:23569 "EHLO colin2.muc.de")
	by vger.kernel.org with ESMTP id S261578AbVDNSCF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 14:02:05 -0400
Date: 14 Apr 2005 20:02:02 +0200
Date: Thu, 14 Apr 2005 20:02:02 +0200
From: Andi Kleen <ak@muc.de>
To: Tim Hockin <thockin@hockin.org>
Cc: Ross Biro <ross.biro@gmail.com>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/Patch 2.6.11] Take control of PCI Master Abort Mode
Message-ID: <20050414180202.GJ50241@muc.de>
References: <4252E827.4080807@google.com> <m14qee221l.fsf@muc.de> <8783be66050412075218b2b0b0@mail.gmail.com> <20050413183725.GG50241@muc.de> <8783be66050413160033e6283d@mail.gmail.com> <20050413232826.GA22698@redhat.com> <8783be66050414102551698d86@mail.gmail.com> <20050414173438.GA9488@hockin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050414173438.GA9488@hockin.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What if it was always on, except when the commandlien was passed
> (eliminate the CONFIG option)?  Really 'leet hacks could tweak a #define
> if they don't like the command line option..

That is basically what I suggested. But test it for a month
in -mm* first and figure out if it needs more black/whitelisting

-Andi
