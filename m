Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266275AbUAWJFF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 04:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266551AbUAWJFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 04:05:05 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:22684 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S266275AbUAWJFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 04:05:01 -0500
Subject: Re: 2.6.2-rc1-mm1 oops with X
From: David Woodhouse <dwmw2@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Glenn Johnson <glennpj@charter.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20040122231814.149c8e8d.akpm@osdl.org>
References: <20040123061927.GA7025@gforce.johnson.home>
	 <20040122231814.149c8e8d.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1074848612.23073.81.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Fri, 23 Jan 2004 09:03:32 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-01-22 at 23:18 -0800, Andrew Morton wrote:
> It is maddeningly hard to debug even when you can reproduce it, which I can
> no longer do.

This is what GDB watchpoints were invented for, surely?

-- 
dwmw2


