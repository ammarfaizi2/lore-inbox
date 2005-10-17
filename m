Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbVJQSET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbVJQSET (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 14:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbVJQSET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 14:04:19 -0400
Received: from 217-195-233-66.dsl.esined.net ([217.195.233.66]:10897 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932081AbVJQSES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 14:04:18 -0400
Subject: Re: PATCH: EDAC, core EDAC support code
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Doug Thompson <norsk5@yahoo.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1129531119.2907.1.camel@laptopd505.fenrus.org>
References: <20051017014845.16415.qmail@web50112.mail.yahoo.com>
	 <1129531119.2907.1.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 17 Oct 2005 18:59:17 +0100
Message-Id: <1129571958.2424.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-10-17 at 08:38 +0200, Arjan van de Ven wrote:
> that doesn't work that way.. with the /proc stuff you add an api/abi,
> which you can't get rid of afterwards, so it's important to get that
> right from the start..... 

The proc interface for this dates back to Linux 2.0 or so. Existing
tools will still expect it for some time.

