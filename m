Return-Path: <linux-kernel-owner+w=401wt.eu-S1761813AbWLISEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761813AbWLISEz (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 13:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761812AbWLISEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 13:04:55 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:35610 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761810AbWLISEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 13:04:54 -0500
Date: Sat, 9 Dec 2006 18:04:52 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Olaf Hering <olaf@aepfle.de>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] more work_struct mess
Message-ID: <20061209180451.GY4587@ftp.linux.org.uk>
References: <20061208091649.GL4587@ftp.linux.org.uk> <20061209112515.GA1923@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061209112515.GA1923@aepfle.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2006 at 12:25:10PM +0100, Olaf Hering wrote:
> This is not enough to get it going:
> 
> error: 'INIT_WORK' undeclared (first use in this function)

.config?
