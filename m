Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264515AbUFHDLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264515AbUFHDLu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 23:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265163AbUFHDLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 23:11:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39815 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264515AbUFHDLt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 23:11:49 -0400
Date: Mon, 7 Jun 2004 23:11:46 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Phy Prabab <phyprabab@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: VM in 2.6
In-Reply-To: <20040607212510.95507.qmail@web51809.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44.0406072311230.30948-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jun 2004, Phy Prabab wrote:

> Are there any control knobs for the scheduler in the
> 2.6.7-x kernels?

Yes.  You can find them in /proc/sys/vm/
They're even documented.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

