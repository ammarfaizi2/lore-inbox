Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264637AbTFLAak (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 20:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264638AbTFLAak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 20:30:40 -0400
Received: from frontb-d.sezampro.yu ([194.106.188.52]:57610 "HELO
	frontb-d.sezampro.yu") by vger.kernel.org with SMTP id S264637AbTFLAak convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 20:30:40 -0400
From: Toplica =?utf-8?q?Tanaskovi=C4=87?= <toptan@sezampro.yu>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: Via KT400 and AGP 8x Support
Date: Thu, 12 Jun 2003 02:44:45 +0200
User-Agent: KMail/1.5.1
References: <20030611212654.61150.qmail@web11307.mail.yahoo.com> <200306120036.21691.toptan@sezampro.yu> <20030611225350.GA522@suse.de>
In-Reply-To: <20030611225350.GA522@suse.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200306120244.45476.toptan@sezampro.yu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dana četvrtak 12. jun 2003. 00:53, Dave Jones je napisao/la:
> That's likely an X limitation. Someone with X-fu needs to hack that up
> so it passes the right things through to agpgart. Would be nice to have
> that in place for the next X release, so that when distros come to start
> shipping 2.6, userspace is up to speed.

	It's going to be difficult one, because, there are no hw. acc. drivers for 
nVidia built in X, and there is no R300 accel. Don't know about nv, but for 
Radeon chips only R300 can engage 8x transfer, so until ATI releases docs, or 
some genius figures how R300 work in 3D, IMHO there is no point of hacking X.

-- 
Pozdrav,
Tanasković Toplica

