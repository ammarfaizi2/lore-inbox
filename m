Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbVJYXEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbVJYXEY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 19:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbVJYXEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 19:04:24 -0400
Received: from bromo.msbb.uc.edu ([129.137.3.146]:56455 "HELO
	bromo.msbb.uc.edu") by vger.kernel.org with SMTP id S932466AbVJYXEY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 19:04:24 -0400
To: alan@lxorguk.ukuu.org.uk, howarth@bromo.msbb.uc.edu
Subject: Re: W2100Z Critical temperature explained
Cc: linux-kernel@vger.kernel.org
Message-Id: <20051025230256.D1BC61DC06D@bromo.msbb.uc.edu>
Date: Tue, 25 Oct 2005 19:02:56 -0400 (EDT)
From: howarth@bromo.msbb.uc.edu (Jack Howarth)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,
   Actually I found a discussion of the issue that I believe I am seeing
at...

http://supportforum.sun.com/hardware/index.php?t=msg&goto=18308&rid=6746&SQ=d7bff636081bc7374f3e861f6672e008

There may be more than one cause, but it seems clear that the earlier
BIOS is less tolerant of fans as they start to wear. The newer BIOS 
probes the fans several times. Hence the user who had to put in a new fan
so he could stay booted long enough to flash the new BIOS and them the
old fan was usable. Ugh.
               Jack
