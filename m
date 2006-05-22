Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWEVNSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWEVNSl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 09:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWEVNSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 09:18:41 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:36302 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1750818AbWEVNSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 09:18:40 -0400
Message-ID: <4471BABE.8070009@cmu.edu>
Date: Mon, 22 May 2006 09:21:02 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Thunderbird 1.5.0.2 (X11/20060503)
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: linux-kernel@vger.kernel.org, arjan@infradead.org, nick@linicks.net
Subject: Re: cannot load *any* modules with 2.4 kernel
References: <446F3F6A.9060004@cmu.edu> <20060520162529.GT11191@w.ods.org> <446FAEE3.6060003@cmu.edu> <20060521054826.GA14334@w.ods.org> <44701017.8000803@cmu.edu> <20060521084055.GA14593@w.ods.org>
In-Reply-To: <20060521084055.GA14593@w.ods.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, i *finally* got it booting and inserting modules!

the culprit was the modversions.

Thanks for everyones help!

- George
