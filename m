Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbWECWt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWECWt1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 18:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWECWt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 18:49:27 -0400
Received: from canuck.infradead.org ([205.233.218.70]:64433 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751380AbWECWt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 18:49:27 -0400
Subject: Re: [RFC] Advanced XIP File System
From: David Woodhouse <dwmw2@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Jared Hulbert <jaredeh@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0605031832230.13546@yvahk01.tjqt.qr>
References: <6934efce0605021453l31a438c4j7c429e6973ab4546@mail.gmail.com>
	 <Pine.LNX.4.61.0605031832230.13546@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Wed, 03 May 2006 23:49:04 +0100
Message-Id: <1146696544.20773.70.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-03 at 18:38 +0200, Jan Engelhardt wrote:
> If 2 MB of RAM are cheaper [as you say] than 1 MB of Flash, where's
> the advantage when XIP uses more flash?

Power consumption.

-- 
dwmw2

