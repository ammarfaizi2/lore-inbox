Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbTJUJox (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 05:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263054AbTJUJox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 05:44:53 -0400
Received: from web40310.mail.yahoo.com ([66.218.78.89]:3080 "HELO
	web40310.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263053AbTJUJow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 05:44:52 -0400
Message-ID: <20031021094451.33861.qmail@web40310.mail.yahoo.com>
Date: Tue, 21 Oct 2003 06:44:51 -0300 (ART)
From: =?iso-8859-1?q?Joilnen=20Leite?= <knl_joi@yahoo.com.br>
Subject: request_region
To: macro@ds2.pg.gda.pl
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

excuse me but

line 400 in  drivers/net/skfp/skfddi.c there are a
request_region for dev->base_addr

and I can't se it released in 428 line for example :) 

Thanks 

Yahoo! Mail - o melhor webmail do Brasil
http://mail.yahoo.com.br
