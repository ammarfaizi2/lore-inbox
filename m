Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264196AbUFYTek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264196AbUFYTek (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 15:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265530AbUFYTek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 15:34:40 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:64902 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264196AbUFYTei
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 15:34:38 -0400
Subject: Re: 2.6.7: fs/jfs/jfs_dtree.c compile error
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Bob Tracy <rct@gherkin.frus.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040624215537.8B8ECDBE2@gherkin.frus.com>
References: <20040624215537.8B8ECDBE2@gherkin.frus.com>
Content-Type: text/plain
Message-Id: <1088180178.2502.54.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 25 Jun 2004 11:16:19 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-24 at 16:55, Bob Tracy wrote:
> Older compilers (including the currently recommended minimum, which is
> 2.95.3) cannot handle the declaration at line 388 in the 2.6.7 version
> of linux/fs/jfs/jfs_dtree.c.  Moving the declaration to line 377 is a
> trivial fix.

This is fixed in the latest BK tree.
-- 
David Kleikamp
IBM Linux Technology Center

