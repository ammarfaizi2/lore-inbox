Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136967AbREJW3U>; Thu, 10 May 2001 18:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136968AbREJW3K>; Thu, 10 May 2001 18:29:10 -0400
Received: from D8FA50AA.ptr.dia.nextlink.net ([216.250.80.170]:40174 "EHLO
	tetsuo.applianceware.com") by vger.kernel.org with ESMTP
	id <S136967AbREJW3F>; Thu, 10 May 2001 18:29:05 -0400
Date: Thu, 10 May 2001 15:25:30 -0700
From: Mike Panetta <mpanetta@applianceware.com>
To: linux-kernel@vger.kernel.org
Subject: ACPI broken in 2.4.4-ac6
Message-ID: <20010510152530.B12281@tetsuo.applianceware.com>
Mail-Followup-To: Mike Panetta <mpanetta@applianceware.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: ApplianceWare
X-Mailer: mutt (ruff!  ruff!)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI seems to be broken on 2.4.4-ac6 or atleast
poweroff is broken.  During bootup all ACPI
prints is that it was enabled, it used to
(in plain jane 2.4.4) print the sleep levels
supported by the bios but does not in ac6.

What could be the cause?

Thanks,
Mike
-- 
