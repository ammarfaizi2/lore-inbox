Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267341AbUHIXLo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267341AbUHIXLo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 19:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267339AbUHIXLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 19:11:43 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:43179 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267345AbUHIXKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 19:10:22 -0400
Date: Mon, 9 Aug 2004 16:10:03 -0700
From: Paul Jackson <pj@sgi.com>
To: Eric Masson <cool_kid@future-ericsoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fork and Exec a process within the kernel
Message-Id: <20040809161003.554a5de1.pj@sgi.com>
In-Reply-To: <4117E68A.4090701@future-ericsoft.com>
References: <4117E68A.4090701@future-ericsoft.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try grep'ing for call_usermodehelper()

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
