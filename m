Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262964AbTEGK15 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 06:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263072AbTEGK15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 06:27:57 -0400
Received: from rth.ninka.net ([216.101.162.244]:47517 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S262964AbTEGK14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 06:27:56 -0400
Subject: Re: 2.5.69-mm2 Kernel panic, possibly network related
From: "David S. Miller" <davem@redhat.com>
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <3EB8DBA0.7020305@aitel.hist.no>
References: <20030506232326.7e7237ac.akpm@digeo.com>
	 <3EB8DBA0.7020305@aitel.hist.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052304024.9817.3.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 May 2003 03:40:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-07 at 03:10, Helge Hafting wrote:
> 2.5.69-mm1 is fine, 2.5.69-mm2 panics after a while even under very
> light load.

Do you have AF_UNIX built modular?

-- 
David S. Miller <davem@redhat.com>
