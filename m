Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263903AbTKZCVB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 21:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263937AbTKZCVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 21:21:01 -0500
Received: from rth.ninka.net ([216.101.162.244]:21124 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263903AbTKZCT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 21:19:56 -0500
Date: Tue, 25 Nov 2003 18:19:45 -0800
From: "David S. Miller" <davem@redhat.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, francois+kernel@nikita.cx
Subject: Re: [Bugme-new] [Bug 1595] New: Oops in tcp_v4_get_port (fwd)
Message-Id: <20031125181945.4098a2ff.davem@redhat.com>
In-Reply-To: <60420000.1069795076@flay>
References: <60420000.1069795076@flay>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Nov 2003 13:17:56 -0800
"Martin J. Bligh" <mbligh@aracnet.com> wrote:

> http://bugme.osdl.org/show_bug.cgi?id=1595
> 
>            Summary: Oops in tcp_v4_get_port
>     Kernel Version: 2.6.0-test9
>             Status: NEW
>           Severity: high
>              Owner: bugme-janitors@lists.osdl.org
>          Submitter: francois+kernel@nikita.cx

Fixed in test10
