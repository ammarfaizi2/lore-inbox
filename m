Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265932AbUAULtV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 06:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265935AbUAULtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 06:49:21 -0500
Received: from c211-28-164-234.eburwd2.vic.optusnet.com.au ([211.28.164.234]:7040
	"EHLO willster") by vger.kernel.org with ESMTP id S265932AbUAULtT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 06:49:19 -0500
Subject: Re: OOPS: cdrecord -scanbus on benh 2.5 tree causes oops
From: Stewart Smith <stewart@linux.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, debian-powerpc@lists.debian.org
In-Reply-To: <1074634670.739.24.camel@gaston>
References: <1074607152.21539.15.camel@willster>
	 <1074634670.739.24.camel@gaston>
Content-Type: text/plain
Organization: Linux Australia
Message-Id: <1074683884.2623.4.camel@willster>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 21 Jan 2004 22:18:06 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-01-21 at 08:37, Benjamin Herrenschmidt wrote:
> As Colin says, ide-scsi is deprecated :) Anyway, it shouldn't oops.

known and noted - but the point was yeah, shouldn't oops.

> and let me know if the problem is still there in my current 2.6.1-ben1 ?

Seems to be okay in your current tree (rsyned today). Although I just
found a HFS related oops....

-- 
Stewart Smith (stewart@linux.org.au)
Vice President, Linux Australia


