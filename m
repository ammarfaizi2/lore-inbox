Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131666AbRA3BI7>; Mon, 29 Jan 2001 20:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131547AbRA3BIm>; Mon, 29 Jan 2001 20:08:42 -0500
Received: from D8FA50AA.ptr.dia.nextlink.net ([216.250.80.170]:24890 "EHLO
	tetsuo.applianceware.com") by vger.kernel.org with ESMTP
	id <S131945AbRA3BIh>; Mon, 29 Jan 2001 20:08:37 -0500
Date: Mon, 29 Jan 2001 17:09:11 -0800
From: Mike Panetta <mpanetta@applianceware.com>
To: linux-kernel@vger.kernel.org
Subject: EXPORT_SYMTAB and kernel 2.2.x
Message-ID: <20010129170911.G11684@tetsuo.applianceware.com>
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

I am trying to add some drivers to kernel 2.2.16
and I think I have everything done right except
that when it tries to compile the driver I get an
error message saying that EXPORT_SYMTAB is not
defined.  How do I fix this?  I have added a target
to the Config.in and I have added what I think to
be appropriate lines to the Makefile (to check
the config vars defined in Config.in) but I still
get the error.  Any help is greatly appreciated!

Thanks,
Mike


-- 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
