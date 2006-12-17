Return-Path: <linux-kernel-owner+w=401wt.eu-S1752789AbWLQPL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789AbWLQPL5 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 10:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752786AbWLQPL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 10:11:57 -0500
Received: from smtp-dmz-230-sunday.dmz.nerim.net ([195.5.254.230]:57713 "EHLO
	kellthuzad.dmz.nerim.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752789AbWLQPL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 10:11:56 -0500
Date: Sun, 17 Dec 2006 16:10:51 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Magnus Damm <damm@opensource.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.20-rc1] fix vm_events_fold_cpu() build breakage
Message-Id: <20061217161051.18e3cf77.khali@linux-fr.org>
In-Reply-To: <Pine.LNX.4.64.0612161035160.5044@schroedinger.engr.sgi.com>
References: <20061215030610.24898.8839.sendpatchset@localhost>
	<Pine.LNX.4.64.0612161035160.5044@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Dec 2006 10:35:29 -0800 (PST), Christoph Lameter wrote:
> On Fri, 15 Dec 2006, Magnus Damm wrote:
> 
> > fix vm_events_fold_cpu() build breakage
> 
> Acked-by: Christoph Lameter <clameter@sgi.com>

I've hit that one too. Can this fix be sent upstream quickly please?

Thanks,
-- 
Jean Delvare
