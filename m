Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbVKNNeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbVKNNeW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 08:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbVKNNeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 08:34:22 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:62408 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1750722AbVKNNeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 08:34:22 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] mark text section read-only
References: <20051107105624.GA6531@infradead.org>
	<20051107105807.GB6531@infradead.org>
	<1131372374.23658.1.camel@windu.rchland.ibm.com>
	<1131373248.2858.17.camel@laptopd505.fenrus.org>
	<2cd57c900511110139v221ed3f3m@mail.gmail.com>
	<1131702428.2833.8.camel@laptopd505.fenrus.org>
	<2cd57c900511111057n3a7741ddw@mail.gmail.com>
	<20051111190447.GA14481@everest.sosdg.org>
From: "Linh Dang" <linhd@nortel.com>
Organization: Null
Date: Mon, 14 Nov 2005 08:34:08 -0500
In-Reply-To: <20051111190447.GA14481@everest.sosdg.org> (Coywolf Qi Hunt's
 message of "Fri, 11 Nov 2005 14:04:47 -0500")
Message-ID: <wn5fypzl5f3.fsf@linhd-2.ca.nortel.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


on PPC32, the kernel uses memory thru BAT registers. How would this
works?

-- 
Linh Dang
