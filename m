Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264021AbTE0Rwc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 13:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264010AbTE0Ruz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 13:50:55 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:18894
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263979AbTE0RtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 13:49:24 -0400
Subject: Re: 2.4.20 AMD 74xx IDE cable detection problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Gallafent <william.gallafent@virgin.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0305271808560.1589-100000@flatlounge.oldvicarage>
References: <Pine.LNX.4.44.0305271808560.1589-100000@flatlounge.oldvicarage>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054055082.18815.5.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 May 2003 18:04:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-05-27 at 18:34, William Gallafent wrote:
> Hi,
> 
> I've found mention of similar problems (80w cables being incorrectly
> detected as 40w under various circumstances) in the list archives, but
> not of exactly this. I'm using stock SuSE 8.2 kernel 2.4.20-64GB-SMP
> at the moment.

Should be fixed by 2.4.21rc4

