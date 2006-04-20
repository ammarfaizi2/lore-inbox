Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWDTGu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWDTGu3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 02:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWDTGu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 02:50:29 -0400
Received: from mail.gmx.de ([213.165.64.20]:14491 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751265AbWDTGu2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 02:50:28 -0400
X-Authenticated: #14349625
Subject: Re: 2.6.16.1 & D state processes
From: Mike Galbraith <efault@gmx.de>
To: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1145515521.9712.8.camel@homer>
References: <20060420055422.37845.qmail@web52610.mail.yahoo.com>
	 <1145515521.9712.8.camel@homer>
Content-Type: text/plain
Date: Thu, 20 Apr 2006 08:51:19 +0200
Message-Id: <1145515879.9712.11.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-20 at 08:45 +0200, Mike Galbraith wrote:

> Good idea.  What time source are you using?  I'd try plain old pit.

(Looking back, I see you're using pm timer.)

