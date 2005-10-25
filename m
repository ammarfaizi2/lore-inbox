Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbVJYQDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbVJYQDH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 12:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbVJYQDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 12:03:07 -0400
Received: from reserv6.univ-lille1.fr ([193.49.225.20]:59603 "EHLO
	reserv6.univ-lille1.fr") by vger.kernel.org with ESMTP
	id S932191AbVJYQDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 12:03:05 -0400
Message-ID: <435E5720.6030105@tremplin-utc.net>
Date: Wed, 26 Oct 2005 01:02:40 +0900
From: Eric Piel <eric.piel@tremplin-utc.net>
User-Agent: Thunderbird 1.4.1 (Windows/20051006)
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: jonathan@jonmasters.org, jonmasters@gmail.com,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>
Subject: Re: /proc/kcore size incorrect ? (OT)
References: <20051023235806.1a4df9ab@werewolf.able.es>	<35fb2e590510231613u492d24c6k4d65ff3ac5ffcee6@mail.gmail.com> <20051024015710.29a02e63@werewolf.able.es>
In-Reply-To: <20051024015710.29a02e63@werewolf.able.es>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-USTL-MailScanner-Information: Please contact the ISP for more information
X-USTL-MailScanner: Found to be clean
X-USTL-MailScanner-From: eric.piel@tremplin-utc.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
:
> 
> It looks really silly to have a motd say "wellcome to this box, it has
> 2 xeons and 1022 Mb of RAM".
Ok, everyone seems to go with his idea on this thread so I'd like to 
share mine too :-P

If you want to know how much _physical_ memory there is on your 
computer, then a good way would be too use dmidecode. The parsing might 
require more work than a "du" but you will never have trouble with 
rounding...

Eric
