Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbUD3XfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbUD3XfZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 19:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUD3XfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 19:35:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:63643 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261852AbUD3XfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 19:35:22 -0400
Date: Fri, 30 Apr 2004 16:34:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: FabF <Fabian.Frederick@skynet.be>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org, pbadari@us.ibm.com
Subject: Re: [PATCH 2.6.6-rc3-mm1] Add maxthinktime to sysfs
Message-Id: <20040430163459.401d3421.akpm@osdl.org>
In-Reply-To: <1083368224.4976.9.camel@bluerhyme.real3>
References: <1083364002.6303.9.camel@bluerhyme.real3>
	<20040430154246.2019f9ec.akpm@osdl.org>
	<1083368224.4976.9.camel@bluerhyme.real3>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FabF <Fabian.Frederick@skynet.be> wrote:
>
>        I notice huge variations in first seconds of a 10 client
>  throughput activity as attached (5,100,300 as maxthinktime).
>  It's just another parameter I'd like to play with ;)

Fair enough.  Interesting result.

Can you describe and/or publish ffbench?
