Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263647AbTLSWLz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 17:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263650AbTLSWLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 17:11:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32896 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263647AbTLSWLy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 17:11:54 -0500
Date: Fri, 19 Dec 2003 17:11:51 -0500
From: Bill Nottingham <notting@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: problems with sermouse in 2.6.0
Message-ID: <20031219221151.GB8918@devserv.devel.redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using a very generic old logictech mouse, the sermouse driver doesn't
appear to work at all; no messages from the kernel, and no data
ever coming through the input layer.

Raw reads of /dev/ttyS0 do show the mouse passing data - am I missing
something obvious on how to set it up?

Bill
