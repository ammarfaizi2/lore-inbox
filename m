Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265870AbUATXBp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 18:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265871AbUATXBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 18:01:45 -0500
Received: from hera.cwi.nl ([192.16.191.8]:49026 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S265870AbUATXBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 18:01:43 -0500
From: Andries.Brouwer@cwi.nl
Date: Wed, 21 Jan 2004 00:01:36 +0100 (MET)
Message-Id: <UTC200401202301.i0KN1at26447.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: [OT] POSIX manpages
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just received permission from the IEEE and the Open Group
to distribute part of POSIX 1003.1-2003.

Wrote some silly script to convert these things to nroff
and put man-pages-1.65 at the usual places.

People who like to see POSIX pages first put
MANSECT=1p:1:8:0p:3p:2:3:4:5:6:7:9:tcl:n:l:p:o
or so in their environment (or edit /usr/share/misc/man.conf).
Other put 0p:1p:3p later in this ordering.

0p is headers, 1p is utilities, 3p is functions.

No doubt the output of my script will have a thousand flaws,
but I am ill right now and do not want to look at them.
Of course, comments are welcome.

Andries
