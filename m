Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964968AbWHHPmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbWHHPmP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 11:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbWHHPmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 11:42:14 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:51847 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964968AbWHHPmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 11:42:13 -0400
Subject: Re: [PATCH] sys_getppid oopses on debug kernel
From: Dave Hansen <haveblue@us.ibm.com>
To: =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Cc: Kirill Korotaev <dev@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060808153435.GB2720@atjola.homenet>
References: <44D865FD.1040806@sw.ru>
	 <1155050817.19249.42.camel@localhost.localdomain>
	 <20060808153435.GB2720@atjola.homenet>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 08 Aug 2006 08:41:41 -0700
Message-Id: <1155051701.19249.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-08 at 17:34 +0200, Björn Steinbrink wrote:
> See this thread: http://lkml.org/lkml/2006/8/8/215

Bah.  I see it now.

I'll put this on the list of things that still have to be fixed before
we do any kind of memory removal.  This will definitely be a bug there.

-- Dave

