Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261286AbSI1NSA>; Sat, 28 Sep 2002 09:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261316AbSI1NSA>; Sat, 28 Sep 2002 09:18:00 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:21774 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261286AbSI1NR7>; Sat, 28 Sep 2002 09:17:59 -0400
Date: Sat, 28 Sep 2002 14:23:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Lightweight Patch Manager <patch@luckynet.dynu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@conectiva.com.br>,
       Tomas Szepe <szepe@pinerecords.com>, Zach Brown <zab@zaboo.net>
Subject: Re: [PATCH][2.5] Single linked headed lists for Linux, v3
Message-ID: <20020928142319.A32048@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Lightweight Patch Manager <patch@luckynet.dynu.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Rik van Riel <riel@conectiva.com.br>,
	Tomas Szepe <szepe@pinerecords.com>, Zach Brown <zab@zaboo.net>
References: <20020928093335.E7A794@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020928093335.E7A794@hawkeye.luckynet.adm>; from patch@luckynet.dynu.com on Sat, Sep 28, 2002 at 09:33:35AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please kill the sillz ifdef __KERNEL__ and convert to inlines.
After that one could start to ctuallz review the implementation..

