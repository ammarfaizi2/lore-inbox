Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262761AbULQHon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262761AbULQHon (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 02:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbULQHon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 02:44:43 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:21214 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262761AbULQHom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 02:44:42 -0500
Date: Fri, 17 Dec 2004 08:44:32 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Mitchell Blank Jr <mitch@sfgoth.com>
cc: krishna <krishna.c@globaledgesoft.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Significance of do ... while (0)
In-Reply-To: <20041217042911.GH76532@gaz.sfgoth.com>
Message-ID: <Pine.LNX.4.61.0412170843530.14529@yvahk01.tjqt.qr>
References: <41C25BDC.8080404@globaledgesoft.com> <20041217042911.GH76532@gaz.sfgoth.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>    Can any one explain the importance of do  ... while (0)
>
>It's a standard C programming practice; more info is available from
>your local search engine:
>  http://www.google.com/search?lr=&c2coff=1&q=%22while%280%29%22

Why? {} would suffice, no need to do{}while(0)



Jan Engelhardt
-- 
ENOSPC
