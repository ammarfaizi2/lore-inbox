Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284263AbRLGRga>; Fri, 7 Dec 2001 12:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284260AbRLGRgV>; Fri, 7 Dec 2001 12:36:21 -0500
Received: from ns.tasking.nl ([195.193.207.2]:20490 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S284263AbRLGRgM>;
	Fri, 7 Dec 2001 12:36:12 -0500
Date: Fri, 7 Dec 2001 18:34:18 +0100
From: Frank van Maarseveen <fvm@altium.nl>
To: linux-kernel@vger.kernel.org
Subject: rp_filter and iptables
Message-ID: <20011207183418.A20363@espoo.tasking.nl>
Reply-To: frank.van.maarseveen@altium.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Subliminal-Message: Use Linux!
Organization: ALTIUM Software BV
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does /proc/sys/net/ipv4/conf/*/rp_filter apply to
packets which travel through INPUT and OUTPUT, or
packets which go only through FORWARD or all?

-- 
Frank
