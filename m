Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263327AbTJQHh5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 03:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263328AbTJQHh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 03:37:57 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:28075 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S263327AbTJQHh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 03:37:56 -0400
Date: Fri, 17 Oct 2003 09:37:42 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Torben Mathiasen <torben.mathiasen@hp.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFT][PATCH] fix ServerWorks PIO auto-tuning
Message-ID: <20031017073742.GA12489@louise.pinerecords.com>
References: <200310162344.09021.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310162344.09021.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct-16 2003, Thu, 23:44 +0200
Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:

> I wonder if this patch fixes problems (reported back in 2.4.21 days)
> with CSB5 IDE and Compaq Proliant machines.  Please test it if you can.

Sure.  What kernel series is the patch against?

-- 
Tomas Szepe <szepe@pinerecords.com>
