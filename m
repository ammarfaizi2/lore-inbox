Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263346AbTJUUNl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 16:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263349AbTJUUNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 16:13:41 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:33295 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263346AbTJUUNj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 16:13:39 -0400
Date: Tue, 21 Oct 2003 22:23:10 +0200
To: James Simmons <jsimmons@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Valdis.Kletnieks@vt.edu,
       schlicht@uni-mannheim.de, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test8-mm1
Message-ID: <20031021202310.GA14993@hh.idb.hist.no>
References: <20031020185613.7d670975.akpm@osdl.org> <Pine.LNX.4.44.0310211846210.32738-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310211846210.32738-100000@phoenix.infradead.org>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 21, 2003 at 06:47:41PM +0100, James Simmons wrote:
> 
> Okay I see people are having alot of problems in the -mm tree. I don't 
> have any problems but I'm working against Linus tree. Could people try the 
> patch against 2.6.0-test8 and tell me if they still have the same results. 

This patch was fine.  2.6.0-test8 with this patch booted and
looked no different from plain 2.6.0-test8.  I am using it for
writing this.  The problems must be in mm1 somehow.

Helge Hafting
