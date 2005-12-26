Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbVLZJbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbVLZJbB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 04:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbVLZJbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 04:31:01 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:17848 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751069AbVLZJbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 04:31:00 -0500
Subject: Re: Testing a ethernet driver
From: Arjan van de Ven <arjan@infradead.org>
To: Conio sandiago <coniodiago@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <993d182d0512252033l1ab88fe1jdc8eb5e658911fe@mail.gmail.com>
References: <993d182d0512252033l1ab88fe1jdc8eb5e658911fe@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 26 Dec 2005 10:30:54 +0100
Message-Id: <1135589454.2935.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-26 at 10:03 +0530, Conio sandiago wrote:
> hello all,
> i have developed a thernet driver for my embedded linux.
> i want to know is there any standard way of testing the same.
> i want to break the system, can anyone suggest good testing scenarios.
> regards

1) post it to linux-kernel, net-dev or mentors-list for review
   (this is a really good test way :)
2) use some programs that use zero copy 


