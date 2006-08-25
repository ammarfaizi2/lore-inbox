Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWHYIxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWHYIxi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 04:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWHYIxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 04:53:38 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:11317 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751285AbWHYIxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 04:53:37 -0400
Subject: Re: [PATCH 1/3] kthread: update s390 cmm driver to use kthread
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060824212241.GB30007@sergelap.austin.ibm.com>
References: <20060824212241.GB30007@sergelap.austin.ibm.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Fri, 25 Aug 2006 10:53:34 +0200
Message-Id: <1156496014.1640.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 16:22 -0500, Serge E. Hallyn wrote:
> This patch compiles and boots fine, but I don't know how to really
> test the driver.

Just tried the patch and tested cmm. Still works fine. Patch added to my
"things-that-will-go-out-after-2.6.18" list of patches.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


