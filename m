Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbTGTJyp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 05:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbTGTJyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 05:54:45 -0400
Received: from tomts13.bellnexxia.net ([209.226.175.34]:45538 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S263875AbTGTJyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 05:54:44 -0400
Date: Sun, 20 Jul 2003 06:08:30 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: how to use "ATAPI:" protocol for IDE CD/RWs??
Message-ID: <Pine.LNX.4.53.0307200606120.17848@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  are there known problems with trying to access IDE CD/RWs directly
through the IDE drivers, rather than using SCSI emulation?  i've tried
testing cdrecord using the "dev=ATAPI:x,y,z" option, and am having
no luck.

  would this be the right forum to supply details?

rday

p.s.  using 2.6.0-test1 kernel.
