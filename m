Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262222AbVAZCh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbVAZCh6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 21:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVAZCh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 21:37:58 -0500
Received: from [83.146.86.58] ([83.146.86.58]:6922 "EHLO mail.ward.six")
	by vger.kernel.org with ESMTP id S262075AbVAZChz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 21:37:55 -0500
Date: Wed, 26 Jan 2005 07:37:49 +0500
From: Denis Zaitsev <zzz@anda.ru>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [BUG] Onboard Ethernet Pro 100 on a SMP box: a very strange errors
Message-ID: <20050126073749.A2142@natasha.ward.six>
Mail-Followup-To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
	nfs@lists.sourceforge.net
References: <20050122014646.A1038@natasha.ward.six> <200501252319.11304.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501252319.11304.vda@port.imtp.ilyichevsk.odessa.ua>; from vda@port.imtp.ilyichevsk.odessa.ua on Tue, Jan 25, 2005 at 11:19:11PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 11:19:11PM +0200, Denis Vlasenko wrote:
> 
> Something corrupts packets. It can be sending NIC, switch in the middle,
> or receiving NIC.

Changing the receiving card closes the question.  Doesn't it matter?
