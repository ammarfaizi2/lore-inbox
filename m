Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262454AbSJWBZV>; Tue, 22 Oct 2002 21:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262460AbSJWBZV>; Tue, 22 Oct 2002 21:25:21 -0400
Received: from lsanca2-ar27-4-46-140-067.lsanca2.dsl-verizon.net ([4.46.140.67]:3471
	"EHLO BL4ST") by vger.kernel.org with ESMTP id <S262454AbSJWBZU>;
	Tue, 22 Oct 2002 21:25:20 -0400
Date: Tue, 22 Oct 2002 18:31:26 -0700
From: Eric Wong <normalperson@yhbt.net>
To: linux-kernel@vger.kernel.org
Cc: vojtech@suse.cz
Subject: [PATCH]hid-interrupt-polling, 2.4.19
Message-ID: <20021023013126.GA20923@BL4ST>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: Tire Smokers Anonymous
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a small patch I made for making USB mouse movement feel
smoother.  It's fully configurable (both at compile time and at
load time).  Hopefully this will help any Linux gamers out there :)

http://www.yhbt.net/normalperson/files/linux/hid-interrupt-polling/

-- 
Eric Wong - normalperson AT yhbt DOT net
