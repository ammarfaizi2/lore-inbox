Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262706AbULQEZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbULQEZG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 23:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbULQEZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 23:25:05 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:15820 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S262706AbULQEYu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 23:24:50 -0500
Date: Thu, 16 Dec 2004 20:29:11 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: krishna <krishna.c@globaledgesoft.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Significance of do ... while (0)
Message-ID: <20041217042911.GH76532@gaz.sfgoth.com>
References: <41C25BDC.8080404@globaledgesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C25BDC.8080404@globaledgesoft.com>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Thu, 16 Dec 2004 20:29:11 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

krishna wrote:
>    Can any one explain the importance of do  ... while (0)

It's a standard C programming practice; more info is available from
your local search engine:
  http://www.google.com/search?lr=&c2coff=1&q=%22while%280%29%22

-Mitch
