Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263992AbTDNWQV (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 18:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263993AbTDNWQV (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 18:16:21 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:49096 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263992AbTDNWQS (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 18:16:18 -0400
Date: Mon, 14 Apr 2003 23:27:27 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][2.5 patch] K6-II/K6-II: enable X86_USE_3DNOW
Message-ID: <20030414222723.GA26161@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
References: <20030414222110.GK9640@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030414222110.GK9640@fs.tum.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 12:21:10AM +0200, Adrian Bunk wrote:
 > If my patch is wrong and this is a RTFM please give me a hint where to 
 > find the "M".
 > 
 > The AMD K6-II and K6-III do support 3DNow!

The 3dnow memory copies aren't a win on anything
earlier than an Athlon iirc.

		Dave

