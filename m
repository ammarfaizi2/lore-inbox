Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932601AbVL2Lu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbVL2Lu0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 06:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932600AbVL2Lu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 06:50:26 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60383 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932599AbVL2LuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 06:50:25 -0500
Subject: Re: PROBLEM: cannot boot 2.6.15-rc6 on Opteron machine
From: Arjan van de Ven <arjan@infradead.org>
To: Erez Zilber <erezz@voltaire.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43B3CA9E.7000804@voltaire.com>
References: <43B3CA9E.7000804@voltaire.com>
Content-Type: text/plain
Date: Thu, 29 Dec 2005 12:50:22 +0100
Message-Id: <1135857022.2935.19.camel@laptopd505.fenrus.org>
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

On Thu, 2005-12-29 at 13:38 +0200, Erez Zilber wrote:
> Hi,
> 
> I've downloaded kernel 2.6.15-rc6 (had the same problem with rc7) and 

2.6.15-rc needs a newer udev version...


