Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265299AbUAAFLM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 00:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265300AbUAAFLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 00:11:12 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:48477 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S265299AbUAAFLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 00:11:11 -0500
Date: Wed, 31 Dec 2003 21:11:01 -0800
From: Paul Jackson <pj@sgi.com>
To: Karel =?ISO-8859-1?Q?Kulhav=FD?= <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compatibility of Nvidia NVNET driver license with GPL
Message-Id: <20031231211101.68ba1362.pj@sgi.com>
In-Reply-To: <20031231073101.A474@beton.cybernet.src>
References: <20031231073101.A474@beton.cybernet.src>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nVidia's _video_ drivers are mostly proprietary code that is not
specific to Linux.  They provide a GPL wrapper or shim that, apparently
in the view of their lawyers, insulates their proprietary code from GPL
license terms.

Perhaps their network software is done the same way?

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
