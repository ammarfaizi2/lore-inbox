Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVDNSeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVDNSeI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 14:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVDNSeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 14:34:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32647 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261429AbVDNSeD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 14:34:03 -0400
Date: Thu, 14 Apr 2005 14:33:56 -0400
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@muc.de>
Cc: Tim Hockin <thockin@hockin.org>, Ross Biro <ross.biro@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/Patch 2.6.11] Take control of PCI Master Abort Mode
Message-ID: <20050414183355.GE23231@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@muc.de>,
	Tim Hockin <thockin@hockin.org>, Ross Biro <ross.biro@gmail.com>,
	linux-kernel@vger.kernel.org
References: <4252E827.4080807@google.com> <m14qee221l.fsf@muc.de> <8783be66050412075218b2b0b0@mail.gmail.com> <20050413183725.GG50241@muc.de> <8783be66050413160033e6283d@mail.gmail.com> <20050413232826.GA22698@redhat.com> <8783be66050414102551698d86@mail.gmail.com> <20050414173438.GA9488@hockin.org> <20050414180202.GJ50241@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050414180202.GJ50241@muc.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2005 at 08:02:02PM +0200, Andi Kleen wrote:
 > > What if it was always on, except when the commandlien was passed
 > > (eliminate the CONFIG option)?  Really 'leet hacks could tweak a #define
 > > if they don't like the command line option..
 > 
 > That is basically what I suggested. But test it for a month
 > in -mm* first and figure out if it needs more black/whitelisting

Indeed. I'm in full agreement with Andi's suggestion.

		Dave

