Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbTDDTbe (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 14:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbTDDTbe (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 14:31:34 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:53168 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S261206AbTDDTbd (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 14:31:33 -0500
Date: Fri, 4 Apr 2003 20:45:01 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Joel Becker <Joel.Becker@oracle.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: WimMark I report for 2.5.66-mm3
In-Reply-To: <20030404191938.GN31739@ca-server1.us.oracle.com>
Message-ID: <Pine.LNX.4.44.0304042041500.2378-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Apr 2003, Joel Becker wrote:

> WimMark I report for 2.5.66-mm3 
> 
> Runs (deadline):  1736.51 1681.50 1010.98
> Runs (antic):  579.62 496.75 517.06
> 
> 	WimMark I is a rough benchmark we have been running
> here at Oracle against various kernels.  Each run tests an OLTP
> workload on the Oracle database with somewhat restrictive memory
> conditions.  etc. etc. etc.

No doubt the people who need to know do already know, but each time
you post this I wish that the long exegesis accompanying the numbers
would say whether a big number is better or worse than a small number.

Hugh

