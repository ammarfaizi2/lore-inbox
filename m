Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263807AbUC3Sbz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 13:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUC3Sbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 13:31:55 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:39603 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263807AbUC3Sbx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 13:31:53 -0500
Date: Tue, 30 Mar 2004 10:30:10 -0800
From: Paul Jackson <pj@sgi.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: wli@holomorphy.com, colpatch@us.ibm.com, linux-kernel@vger.kernel.org,
       mbligh@aracnet.com, akpm@osdl.org, haveblue@us.ibm.com
Subject: Re: [PATCH] mask ADT: bitmap and bitop tweaks [1/22]
Message-Id: <20040330103010.58a6df91.pj@sgi.com>
In-Reply-To: <406997E3.60005@nortelnetworks.com>
References: <20040329041249.65d365a1.pj@sgi.com>
	<1080601576.6742.43.camel@arrakis>
	<20040329235233.GV791@holomorphy.com>
	<406997E3.60005@nortelnetworks.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Huh?  Xor of 0 and 1 is 1.

Heh - no fair introducing facts into this discussion ;).

Actually, you're right.  Though this is a 'latent' bug in
this particular discussion - it doesn't impact any subsequent
points that Bill or I was making.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
