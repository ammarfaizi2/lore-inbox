Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbWDUIQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWDUIQQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 04:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWDUIQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 04:16:12 -0400
Received: from smtp13.wanadoo.fr ([193.252.22.54]:37459 "EHLO
	smtp13.wanadoo.fr") by vger.kernel.org with ESMTP id S932241AbWDUIQK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 04:16:10 -0400
X-ME-UUID: 20060421081603866.D38B6700008A@mwinf1304.wanadoo.fr
Date: Fri, 21 Apr 2006 10:15:00 +0200
From: Mathieu Chouquet-Stringer <mchouque@free.fr>
To: Bob Tracy <rct@gherkin.frus.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-kernel@vger.kernel.org,
       linux-alpha@vger.kernel.org, rth@twiddle.net
Subject: Re: strncpy (maybe others) broken on Alpha
Message-ID: <20060421081500.GA3767@bigip.bigip.mine.nu>
Mail-Followup-To: Mathieu Chouquet-Stringer <mchouque@free.fr>,
	Bob Tracy <rct@gherkin.frus.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	rth@twiddle.net
References: <20060420215723.GA3949@bigip.bigip.mine.nu> <20060421024304.2D851DBA1@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421024304.2D851DBA1@gherkin.frus.com>
User-Agent: Mutt/1.4.2.1i
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 09:43:04PM -0500, Bob Tracy wrote:
> Mathieu -- you mentioned testing with a cross-compile.  Was that the
> case for your reported success?  How about a native compile?  I'm
> pretty sure this *is* a binutils issue, but we don't quite have it
> nailed down yet.

My reported success was with the cross-compiled test case.

I've recompiled 2.16.1 overnight on the alpha and i'm currently
rebuilding the kernel.  I'll keep you posted.
-- 
Mathieu Chouquet-Stringer                           mchouque@free.fr

