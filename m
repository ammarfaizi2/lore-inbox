Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131676AbRA3Bbw>; Mon, 29 Jan 2001 20:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131943AbRA3Bbm>; Mon, 29 Jan 2001 20:31:42 -0500
Received: from D8FA50AA.ptr.dia.nextlink.net ([216.250.80.170]:6207 "EHLO
	tetsuo.applianceware.com") by vger.kernel.org with ESMTP
	id <S131676AbRA3BbX>; Mon, 29 Jan 2001 20:31:23 -0500
Date: Mon, 29 Jan 2001 17:31:57 -0800
From: Mike Panetta <mpanetta@applianceware.com>
To: Mike Panetta <mpanetta@applianceware.com>, linux-kernel@vger.kernel.org
Subject: Re: EXPORT_SYMTAB and kernel 2.2.x
Message-ID: <20010129173157.H11684@tetsuo.applianceware.com>
Mail-Followup-To: Mike Panetta <mpanetta@applianceware.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010129170911.G11684@tetsuo.applianceware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010129170911.G11684@tetsuo.applianceware.com>; from mpanetta@applianceware.com on Mon, Jan 29, 2001 at 05:09:11PM -0800
Organization: ApplianceWare
X-Mailer: mutt (ruff!  ruff!)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nevermind... I figured it out...  I added the modules to the
MX_OBJS list and it worked fine.

Mike

-- 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
