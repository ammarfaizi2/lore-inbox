Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVFLTYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVFLTYl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 15:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVFLTXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 15:23:41 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:10171 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262654AbVFLRKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 13:10:48 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Willy Tarreau <willy@w.ods.org>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] fix small DoS on connect() (was Re: BUG: Unusual TCP Connect() results.)
Date: Sun, 12 Jun 2005 20:10:33 +0300
User-Agent: KMail/1.5.4
Cc: xschmi00@stud.feec.vutbr.cz, alastair@unixtrix.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <42A9C607.4030209@unixtrix.com> <20050611062413.GA1324@pcw.home.local> <20050611074350.GD28759@alpha.home.local>
In-Reply-To: <20050611074350.GD28759@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506122010.33075.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does it seem appropriate for mainline ? In this case, I would also backport
> it to 2.4 and send it to you for inclusion.

It does not contain a comment why it is configurable.
--
vda

