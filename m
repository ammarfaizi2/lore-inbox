Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264711AbTAWACd>; Wed, 22 Jan 2003 19:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264716AbTAWACd>; Wed, 22 Jan 2003 19:02:33 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:9181 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264711AbTAWACd>;
	Wed, 22 Jan 2003 19:02:33 -0500
Date: Wed, 22 Jan 2003 16:03:55 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: colpatch@us.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>
cc: Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [patch][cleanup] Remove __ from topology macros
Message-ID: <346410000.1043280235@flay>
In-Reply-To: <3E2F2DF4.4000507@us.ibm.com>
References: <3E2F2DF4.4000507@us.ibm.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When I originally wrote the patches implementing the in-kernel topology macros, they were meant to be called as a second layer of functions, sans underbars.  This additional layer was deemed unnecessary and summarily dropped.  As such, carrying around (and typing!) all these extra underbars is quite pointless.  Here's a patch to nip this in the (sorta) bud.  The macros only appear in 16 files so far, most of them being the definitions themselves.


Whee! much cleaner ;-) Very cool.

M.

