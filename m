Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWFMAMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWFMAMn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 20:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932669AbWFMAMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 20:12:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:4252 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932320AbWFMAMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 20:12:42 -0400
Subject: Re: VGER does gradual SPF activation  (FAQ matter)
From: David Woodhouse <dwmw2@infradead.org>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060612090521.GE11649@merlin.emma.line.org>
References: <20060610222734.GZ27502@mea-ext.zmailer.org>
	 <20060612090521.GE11649@merlin.emma.line.org>
Content-Type: text/plain
Date: Tue, 13 Jun 2006 01:12:50 +0100
Message-Id: <1150157570.11159.87.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 11:05 +0200, Matthias Andree wrote:
> I believe checking Received: headers of backscatter (that term is used
> in Postfix discussions for "back falling junk") catches a fair amount
> of that junk. 

Backscatter is trivial to deal with by other means -- like BATV.

Presumably we'd never accept bounces to the list addresses _anyway_,
since the lists never send mail from their canonical address.

-- 
dwmw2

