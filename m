Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267211AbSK3Dy5>; Fri, 29 Nov 2002 22:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267212AbSK3Dy5>; Fri, 29 Nov 2002 22:54:57 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:3456 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S267211AbSK3Dy4>; Fri, 29 Nov 2002 22:54:56 -0500
Date: Sat, 30 Nov 2002 15:02:07 +1100
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.5.x / shutdown -r now doesn't
Message-ID: <20021130040207.GA610@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whee...

This has been happening for a wee while now (basically ever since I
moved to 2.5.x I think but I don't use shutdown -r now often).
Essentially, when I do it, the laptop goes through the motions, the
kernel (I assume) says 'Resetting System...' (or Restarting - not too
sure) and then turns itself off. When I do ctrl-alt-del it reboots just
fine. I'm using ACPI if that's of any help.

-- 
        All people are equal,
        But some are more equal then others.
            - George W. Bush Jr, President of the United States
              September 21, 2002 (Abridged version of security speech)
