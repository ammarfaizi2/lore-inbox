Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264953AbTFWIdc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 04:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264994AbTFWIdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 04:33:32 -0400
Received: from hera.cwi.nl ([192.16.191.8]:39098 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264953AbTFWIdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 04:33:31 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 23 Jun 2003 10:47:35 +0200 (MEST)
Message-Id: <UTC200306230847.h5N8lZv11103.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, hch@infradead.org
Subject: Re: [PATCH] loop.c - part 1 of many
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IMHO we should replace it with a by-name selection

But it has already been replaced by by-name selection.
That is what CryptoAPI does.
