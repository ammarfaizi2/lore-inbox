Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbVEZBmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbVEZBmc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 21:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVEZBmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 21:42:31 -0400
Received: from w240.dkm.cz ([62.24.88.240]:2825 "EHLO mail.spitalnik.net")
	by vger.kernel.org with ESMTP id S261659AbVEZBm2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 21:42:28 -0400
From: Jan Spitalnik <jan@spitalnik.net>
To: "roland" <for_spam@gmx.de>
Subject: Re: query, which io scheduler is active?
Date: Thu, 26 May 2005 03:42:25 +0200
User-Agent: KMail/1.8.50
Cc: linux-kernel@vger.kernel.org
References: <015201c56193$ae5f86f0$2000000a@schlepptopp>
In-Reply-To: <015201c56193$ae5f86f0$2000000a@schlepptopp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200505260342.25633.jan@spitalnik.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dne èt 26. kvìtna 2005 03:38 roland napsal(a):
> ok - there are 4 types of io schedulers - but - how can one see/query,
> which i/o scheduler is the currently "active" one?
>

/sys/block/<device>/queue/scheduler

Bye,
	spity

-- 
Jan Spitalnik
jan@spitalnik.net

If everyone used log base e, we'd all be happy!
