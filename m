Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267813AbUHEQ7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267813AbUHEQ7g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 12:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267783AbUHEQ6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 12:58:35 -0400
Received: from mail.convergence.de ([212.84.236.4]:54466 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S267801AbUHEQy2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 12:54:28 -0400
Date: Thu, 5 Aug 2004 18:54:31 +0200
From: Johannes Stezenbach <js@convergence.de>
To: Florian Huber <florian.huber@mnet-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Tuning (stv0299.ko) with SkyStar2/DVB not working with 2.6.8-rc* anymore
Message-ID: <20040805165431.GE2080@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Florian Huber <florian.huber@mnet-online.de>,
	linux-kernel@vger.kernel.org
References: <1090750814.17579.15.camel@suprafluid.huber.lan> <1091574593.24571.13.camel@suprafluid.huber.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091574593.24571.13.camel@suprafluid.huber.lan>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 01:09:53AM +0200, Florian Huber wrote:
> My problem seems to be solved with some 2.6.8-rc2-mm2 and 2.6.8-rc3.
> 
> But the major device node change from 250 to 212 should be emphasized.
> Without the obsolete devfs it is not that easy to find out the new
> device node for an average user.

It's announced prominently on http://linuxtv.org/, and was
listed in the Changelog on kernel.org. What more can we do?

Johannes
