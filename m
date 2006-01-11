Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbWAKSVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbWAKSVZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 13:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbWAKSVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 13:21:25 -0500
Received: from outgoing.tpinternet.pl ([193.110.120.20]:33578 "EHLO
	outgoing.tpinternet.pl") by vger.kernel.org with ESMTP
	id S932435AbWAKSVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 13:21:24 -0500
In-Reply-To: <20060111181252.61498.qmail@web34103.mail.mud.yahoo.com>
References: <20060111181252.61498.qmail@web34103.mail.mud.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BEF11842-40CA-403C-9546-12F55976EF93@neostrada.pl>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Marcin Dalecki <dalecki.marcin@neostrada.pl>
Subject: Re: Is user-space AIO dead?
Date: Wed, 11 Jan 2006 19:20:23 +0100
To: Kenny Simpson <theonetruekenny@yahoo.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2006-01-11, at 19:12, Kenny Simpson wrote:
> If I want a transactional engine (like a database) that needs to  
> persist to stable storage, is it
> still best to use a helper thread to do write/fsync or O_SYNC| 
> O_DIRECT?

Yes.
