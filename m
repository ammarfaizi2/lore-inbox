Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161049AbWFJXG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161049AbWFJXG2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 19:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161050AbWFJXG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 19:06:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11935 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161049AbWFJXG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 19:06:27 -0400
Subject: Re: VGER does gradual SPF activation  (FAQ matter)
From: David Woodhouse <dwmw2@infradead.org>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060610222734.GZ27502@mea-ext.zmailer.org>
References: <20060610222734.GZ27502@mea-ext.zmailer.org>
Content-Type: text/plain
Date: Sun, 11 Jun 2006 00:06:30 +0100
Message-Id: <1149980791.18635.197.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-11 at 01:27 +0300, Matti Aarnio wrote:
> Now that there is even an RFC published about SPF...

Please, don't do this. SPF makes assumptions about email which are just
not true; it rejects perfectly valid mail.

http://david.woodhou.se/why-not-spf.html

-- 
dwmw2

