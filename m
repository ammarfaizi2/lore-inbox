Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264286AbUIAIgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbUIAIgz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 04:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbUIAIer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 04:34:47 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:48112 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264386AbUIAIdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 04:33:47 -0400
Message-Id: <200409010833.i818XPZ04210@owlet.beaverton.ibm.com>
To: Nivedita Singhvi <niv@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: Re: 2.6.9-rc1-mm2 
In-reply-to: Your message of "Tue, 31 Aug 2004 17:49:10 PDT."
             <41351C86.7000704@us.ibm.com> 
Date: Wed, 01 Sep 2004 01:33:25 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for pointing out the specific config options.

Granted a more recent config is warranted .. the one I'm using is
2.6.0-based.  But considering I ran make oldconfig on this and chose
the defaults in each and every case, should I end up with a config that
doesn't compile?  Is there still a config issue here, especially
considering that both rc1 and rc1-mm1 compiled fine using this method?
Or is make oldconfig only going to help for a version or two back?

Rick
