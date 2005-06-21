Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262409AbVFUWfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbVFUWfS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 18:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbVFUWeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 18:34:00 -0400
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:26383 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262336AbVFUVtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 17:49:13 -0400
Date: Tue, 21 Jun 2005 23:49:43 +0200
From: Jean Delvare <khali@linux-fr.org>
To: cutaway@bellsouth.net
Cc: "Denis Vlasenko" <vda@ilport.com.ua>,
       "LKML" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] cleanup patches for strings
Message-Id: <20050621234943.713ecc40.khali@linux-fr.org>
In-Reply-To: <008401c576b1$4f2ec000$2800000a@pc365dualp2>
References: <Pine.LNX.4.62.0506200052320.2415@dragon.hyggekrogen.localhost>
	<200506211359.25632.vda@ilport.com.ua>
	<20050621232409.06a3400e.khali@linux-fr.org>
	<008401c576b1$4f2ec000$2800000a@pc365dualp2>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,... hm, don't you have a name?

> Jean, the default string alignments GCC seems to insist on using are
> going to screw you far more than the extra byte here or there ;->

That's possible, however I can't do anything against GCC personally,
while I can help cleanup the code and possibly actually space a few
bytes here and there. So let's just do it.

Oh, and GCC might end up being smart, who knows.

-- 
Jean Delvare
