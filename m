Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266997AbUBGSAT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 13:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267007AbUBGSAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 13:00:19 -0500
Received: from q.bofh.de ([212.126.220.202]:61200 "EHLO q.bofh.de")
	by vger.kernel.org with ESMTP id S266997AbUBGSAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 13:00:15 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: major network performance difference between 2.4 and 2.6.2-rc2
Mail-Copies-To: nobody
From: Hilko Bengen <bengen@hilluzination.de>
In-Reply-To: <402403A5.4090708@tmr.com> (Bill Davidsen's message of "Fri, 06
 Feb 2004 16:14:13 -0500")
References: <20040204125444.3f2b5e79.akpm@osdl.org>
	<Pine.GSO.4.58.0402042248300.27381@denali.ccs.neu.edu>
	<402403A5.4090708@tmr.com>
Date: Sat, 07 Feb 2004 18:56:15 +0100
Message-ID: <87znbupydc.fsf@hilluzination.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> writes:

> What would be nice is some kind of table approach, hash or tree,
> which allows operations to be matches against all of the IPs in a
> group, and obviously to add/delete entries. I think for simplicity
> individual IPs rather than CIDR blocks are desirable.

Do you mean something like <http://www.hipac.org/>?

-Hilko

