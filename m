Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132398AbRDPXet>; Mon, 16 Apr 2001 19:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132399AbRDPXej>; Mon, 16 Apr 2001 19:34:39 -0400
Received: from jffdns02.or.intel.com ([134.134.248.4]:63458 "EHLO
	hebe.or.intel.com") by vger.kernel.org with ESMTP
	id <S132398AbRDPXef>; Mon, 16 Apr 2001 19:34:35 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE843@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Pavel Machek'" <pavel@suse.cz>,
        Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        Andreas Ferber <aferber@techfak.uni-bielefeld.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Let init know user wants to shutdown
Date: Mon, 16 Apr 2001 16:32:49 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Pavel Machek [mailto:pavel@suse.cz]
> There are 32 signals, and signals can carry more information, if
> required. I really think doing it way UPS-es are done is right
> approach.

I would think that it would make sense to keep shutdown with all the other
power management events. Perhaps it will makes more sense to handle UPS's
through the power management code.

Regards -- Andy

