Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263435AbUE1PQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbUE1PQG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 11:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbUE1PQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 11:16:06 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:17281 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S263435AbUE1PQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 11:16:03 -0400
Date: Fri, 28 May 2004 19:16:01 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Balint Cristian <rezso@rdsor.ro>
Cc: Herbert Poetzl <herbert@13thfloor.at>, linux-admin@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org
Subject: Re: Kernel crash/ oops >= 2.6.5 with gcc 3.4.0 on alpha
Message-ID: <20040528191601.B1117@jurassic.park.msu.ru>
References: <40B726C0.5030400@steudten.com> <20040528123758.GE19544@MAIL.13thfloor.at> <40B74779.40406@steudten.com> <200405281719.20593.rezso@rdsor.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200405281719.20593.rezso@rdsor.ro>; from rezso@rdsor.ro on Fri, May 28, 2004 at 05:19:20PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2004 at 05:19:20PM -0400, Balint Cristian wrote:
> > {standard input}: Assembler messages:
> > {standard input}:7: Warning: setting incorrect section attributes for .got
> >
> Hi  !
> 
> I got same error with 2.6.7-rc1 !

It's not an error, just a warning, and it's unrelated to reported oops.

Ivan.
