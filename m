Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265932AbUHQW4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265932AbUHQW4M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 18:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268494AbUHQW4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 18:56:12 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:15316 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265932AbUHQWy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 18:54:28 -0400
Date: Tue, 17 Aug 2004 15:53:21 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: hari@in.ibm.com, linux-kernel@vger.kernel.org, fastboot@osdl.org
cc: akpm@osdl.org, Suparna Bhattacharya <suparna@in.ibm.com>, litke@us.ibm.com,
       ebiederm@xmission.com
Subject: Re: [PATCH][6/6]Device abstraction for linear/raw view of the dump
Message-ID: <175200000.1092783201@flay>
In-Reply-To: <20040817121332.GG3916@in.ibm.com>
References: <20040817120239.GA3916@in.ibm.com> <20040817120531.GB3916@in.ibm.com> <20040817120717.GC3916@in.ibm.com> <20040817120809.GD3916@in.ibm.com> <20040817120911.GE3916@in.ibm.com> <20040817121017.GF3916@in.ibm.com> <20040817121332.GG3916@in.ibm.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch contains the code that enables us to access the 
> previous kernel's memory as /dev/hmem.

One of the bits of feedback we got at kernel summit was that nobody
liked the /dev/hmem name ... could we change it to /dev/oldmem, perhaps?

Thanks,

M.

