Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266149AbUBCW03 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 17:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266150AbUBCW03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 17:26:29 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:59838 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266149AbUBCW02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 17:26:28 -0500
Date: Tue, 03 Feb 2004 14:26:19 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Dave Hansen <haveblue@us.ibm.com>, Alok Mooley <rangdi@yahoo.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
Subject: Re: Active Memory Defragmentation: Our implementation & problems
Message-ID: <6020000.1075847179@flay>
In-Reply-To: <1075843615.28252.17.camel@nighthawk>
References: <20040203044651.47686.qmail@web9705.mail.yahoo.com> <1075843615.28252.17.camel@nighthawk>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'll stop there for now.  There seems to be a lot of code in the file
> that's one-off from current kernel code.  I think a close examination of
> currently available kernel functions could drasticly reduce the size of
> your module.  

Preferably to 0 ... this should be part of the core kernel, not a module.

M.

