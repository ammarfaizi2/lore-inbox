Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263488AbTH3KmZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 06:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263494AbTH3KmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 06:42:25 -0400
Received: from anchor-post-39.mail.demon.net ([194.217.242.80]:62118 "EHLO
	anchor-post-39.mail.demon.net") by vger.kernel.org with ESMTP
	id S263488AbTH3KmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 06:42:24 -0400
From: Matt Gibson <gothick@gothick.org.uk>
Organization: The Wardrobe Happy Cow Emporium
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0: module char_10_135
Date: Sat, 30 Aug 2003 11:39:01 +0100
User-Agent: KMail/1.5.3
References: <Pine.LNX.4.53.0308201736040.178@bigred.russwhit.org> <20030830100823.GM7038@fs.tum.de>
In-Reply-To: <20030830100823.GM7038@fs.tum.de>
X-Pointless-MIME-Header: yes
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308301139.01856.gothick@gothick.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 Aug 2003 11:08, Adrian Bunk wrote:
> Minor 135 is rtc.

Indeed.  If it's any help, my rtc's working fine under 2.6.0 (test-4) with...

alias char-major-10-135 rtc

...in my /etc/modprobe.conf.

M

-- 
"It's the small gaps between the rain that count,
 and learning how to live amongst them."
	      -- Jeff Noon
