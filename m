Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265212AbUBECdn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 21:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265216AbUBECdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 21:33:43 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:21906 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265212AbUBECdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 21:33:41 -0500
Subject: Re: [Bugme-new] [Bug 2019] New: Bug from the mm subsystem involving
	X  (fwd)
From: Keith Mannthey <kmannth@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.58.0402041800320.2086@home.osdl.org>
References: <51080000.1075936626@flay>
	<Pine.LNX.4.58.0402041539470.2086@home.osdl.org> <60330000.1075939958@flay>
	<64260000.1075941399@flay> <Pine.LNX.4.58.0402041639420.2086@home.osdl.org>
	<20040204165620.3d608798.akpm@osdl.org>
	<Pine.LNX.4.58.0402041719300.2086@home.osdl.org>
	<1075946211.13163.18962.camel@dyn318004bld.beaverton.ibm.com> 
	<Pine.LNX.4.58.0402041800320.2086@home.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 04 Feb 2004 18:33:19 -0800
Message-Id: <1075948401.13163.19077.camel@dyn318004bld.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-04 at 18:04, Linus Torvalds wrote:

> If VM_IO gets rid of this, then we should immediately apply the patch.


I tried Andrews VM_IO patch earlier today but it didn't fix the
problem.  

Keith 

