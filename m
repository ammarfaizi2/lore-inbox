Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262629AbVBYGlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbVBYGlZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 01:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262630AbVBYGlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 01:41:25 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:32414 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262629AbVBYGlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 01:41:24 -0500
Subject: Re: [PATCH] audit: handle loginuid through proc
From: Albert Cahalan <albert@users.sf.net>
To: sds@epoch.ncsc.mil, Andrew Morton OSDL <akpm@osdl.org>, serue@us.ibm.com
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 25 Feb 2005 01:14:52 -0500
Message-Id: <1109312092.5125.187.camel@cube>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Assuming you'd like ps to print the LUID, how about
putting it with all the others? There are "Uid:"
lines in the /proc/*/status files.


