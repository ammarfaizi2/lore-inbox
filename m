Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266318AbTABSep>; Thu, 2 Jan 2003 13:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266320AbTABSeo>; Thu, 2 Jan 2003 13:34:44 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:28544 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266318AbTABSeo>; Thu, 2 Jan 2003 13:34:44 -0500
Date: Thu, 02 Jan 2003 10:36:17 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: uaca@alumni.uv.es
cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_X86_TSC_DISABLE question
Message-ID: <344570000.1041532576@flay>
In-Reply-To: <20030102175740.GA13389@pusa.informat.uv.es>
References: <20030102144409.GB8309@pusa.informat.uv.es> <124500000.1041529180@titus> <20030102175740.GA13389@pusa.informat.uv.es>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there a way to verify this? or must I contact the motherboard maker and
> ask for it? how I should ask it?

I'd just assume that it works unless you have > 4 CPUs. Boxes (like mine)
where it doesn't work tend to be arcane NUMA things with large CPU counts.

M.

