Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266898AbUIIUPG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266898AbUIIUPG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 16:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267648AbUIIUOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 16:14:48 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:50413 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265287AbUIIUN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 16:13:27 -0400
Date: Thu, 9 Sep 2004 13:13:21 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: linux kernel <linux-kernel@vger.kernel.org>,
       linux ia64 kernel <linux-ia64@vger.kernel.org>
Subject: Hanging process on SMP machines?
Message-ID: <20040909201321.GA21492@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I notice that a process may hang on SMP machines at random:

http://bugzilla.kernel.org/show_bug.cgi?id=3332

I can reliably trigger it within 15 minutes under SMP kernel on P4 HT
and 4-way ia64 machines. Has anyone else seen it?


H.J.
