Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262358AbUK3UEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbUK3UEn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 15:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbUK3UEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 15:04:25 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:17310 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262301AbUK3UAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 15:00:48 -0500
Subject: Re: [PATCH 2.4] serial closing_wait and close_delay
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ian Abbott <abbotti@mev.co.uk>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41ACC49A.20807@mev.co.uk>
References: <41ACC49A.20807@mev.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101841028.25628.109.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 30 Nov 2004 18:57:08 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-11-30 at 19:06, Ian Abbott wrote:
> Dear Marcelo,
> 
> This patch should fix various problems with the closing_wait and 
> close_delay serial parameters, but I can only test the standard serial 
> driver.

Thanks - I've added that to my 2.6.x serial todo pile if nobody else
does it first.


