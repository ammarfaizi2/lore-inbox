Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266882AbUHCXJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266882AbUHCXJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 19:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266902AbUHCXJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 19:09:56 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:414 "EHLO
	mail-out.m-online.net") by vger.kernel.org with ESMTP
	id S266882AbUHCXJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 19:09:55 -0400
Subject: Re: Tuning (stv0299.ko) with SkyStar2/DVB not working with
	2.6.8-rc* anymore
From: Florian Huber <florian.huber@mnet-online.de>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1090750814.17579.15.camel@suprafluid.huber.lan>
References: <1090750814.17579.15.camel@suprafluid.huber.lan>
Content-Type: text/plain
Message-Id: <1091574593.24571.13.camel@suprafluid.huber.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 04 Aug 2004 01:09:53 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My problem seems to be solved with some 2.6.8-rc2-mm2 and 2.6.8-rc3.

But the major device node change from 250 to 212 should be emphasized.
Without the obsolete devfs it is not that easy to find out the new
device node for an average user.

   Florian

