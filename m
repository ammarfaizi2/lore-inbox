Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263777AbUD0Fhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbUD0Fhq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 01:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbUD0Fhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 01:37:46 -0400
Received: from prime.hereintown.net ([141.157.132.3]:47006 "EHLO
	prime.hereintown.net") by vger.kernel.org with ESMTP
	id S263777AbUD0Fho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 01:37:44 -0400
Subject: Re: 2.6.6-rc2-mm2 + Adaptec I2O
From: Chris Meadors <clubneon@hereintown.net>
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <408DE95F.5010201@tequila.co.jp>
References: <408DE95F.5010201@tequila.co.jp>
Content-Type: text/plain
Message-Id: <1083044111.1573.3.camel@clubneon.clubneon.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 27 Apr 2004 01:37:35 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-27 at 01:02, Clemens Schwaighofer wrote:

> Some old game, same stuff again. Linux-2.6.6-rc2 + mm2 and the adaptec
> i2o is still not compiling. There is a patch swirring around the
> internet for 2.6.5 where the kernel compiles (thought i couldn't reboot
> the box yet, so no "real" expierence).
> 
> What is the status? Will there be ever a 2.6.x kernel with a working i2o
> driver? Do I have to blackmail Adaptec ;) ?

If it is the same patch I'm thinking of, I'm using it on a
(light-weight) production server.  No ill effects felt here.  Although
it doesn't seem to be recommended on 64-bit machines.

-- 
Chris

