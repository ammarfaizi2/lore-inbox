Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264986AbSJaApr>; Wed, 30 Oct 2002 19:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264992AbSJaApr>; Wed, 30 Oct 2002 19:45:47 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:60891 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264986AbSJaApq>;
	Wed, 30 Oct 2002 19:45:46 -0500
Subject: How to get a local IPv4 address from within a kernel module?
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.2a (Intl) 23 November 1999
Message-ID: <OFC7D1C5DF.EA41CD79-ON87256C63.00044A15@us.ibm.com>
From: Juan Gomez <juang@us.ibm.com>
Date: Wed, 30 Oct 2002 16:52:05 -0800
X-MIMETrack: Serialize by Router on D03NM694/03/M/IBM(Release 6.0|September 26, 2002) at
 10/30/2002 17:52:05
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is there any standard way of doing this? I looked into ipv4 code but I did
not find a function that would provide a direct, clean way to query the
local IPv4 addresses of a given node.
If this information is not available could we create an interface for it?
Any suggestions on the way to do it?

The interfaces provided to user-level applications do the copy to/from user
that I guess will not work with kernel modules...

Juan

