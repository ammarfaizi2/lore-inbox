Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030336AbWGTXNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030336AbWGTXNA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 19:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030402AbWGTXNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 19:13:00 -0400
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:60592 "HELO
	smtp104.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030336AbWGTXM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 19:12:59 -0400
Date: Thu, 20 Jul 2006 16:12:46 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Nathan Scott <nathans@sgi.com>, David Greaves <david@dgreaves.com>,
       Kasper Sandberg <lkml@metanurb.dk>,
       Torsten Landschoff <torsten@debian.org>, linux-kernel@vger.kernel.org,
       xfs@oss.sgi.com, ml@magog.se, radsaq@gmail.com
Subject: Re: FAQ updated (was Re: XFS breakage...)
Message-ID: <20060720231245.GA32195@tuatara.stupidest.org>
References: <44BF8500.1010708@dgreaves.com> <20060720161121.GA26748@tuatara.stupidest.org> <20060721081452.B1990742@wobbly.melbourne.sgi.com> <Pine.LNX.4.64.0607201817450.23697@p34.internal.lan> <20060721082448.C1990742@wobbly.melbourne.sgi.com> <Pine.LNX.4.64.0607201843020.2619@p34.internal.lan> <20060721085230.F1990742@wobbly.melbourne.sgi.com> <Pine.LNX.4.64.0607201855270.2652@p34.internal.lan> <20060721090015.G1990742@wobbly.melbourne.sgi.com> <Pine.LNX.4.64.0607201910010.20652@p34.internal.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607201910010.20652@p34.internal.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2006 at 07:10:46PM -0400, Justin Piszcz wrote:

> I can run this over and over, and the result is the same?

lost+found is recreated every time, rename it and you'll get less
output
