Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262664AbSKIU6f>; Sat, 9 Nov 2002 15:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262665AbSKIU6f>; Sat, 9 Nov 2002 15:58:35 -0500
Received: from streefland.xs4all.nl ([213.84.249.15]:64640 "EHLO
	zaphod.de.bilt") by vger.kernel.org with ESMTP id <S262664AbSKIU6e>;
	Sat, 9 Nov 2002 15:58:34 -0500
Date: Sat, 9 Nov 2002 22:05:18 +0100
From: Dick Streefland <Dick.Streefland@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: aha152x_cs pcmcia in kernel instead of a module?
Message-ID: <20021109210518.GA30144@streefland.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a technical reason why the aha152x pcmcia driver must be
built as a module, and cannot be compiled into the kernel? Other
pcmcia drivers such as the 3c589 network driver can be compiled in.

-- 
Dick Streefland                    ////               De Bilt
dick.streefland@xs4all.nl         (@ @)       The Netherlands
------------------------------oOO--(_)--OOo------------------
