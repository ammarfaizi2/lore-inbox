Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283268AbRLOS1c>; Sat, 15 Dec 2001 13:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283314AbRLOS1V>; Sat, 15 Dec 2001 13:27:21 -0500
Received: from pcow024o.blueyonder.co.uk ([195.188.53.126]:49936 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S283268AbRLOS1J>;
	Sat, 15 Dec 2001 13:27:09 -0500
Message-ID: <T57d82477aeac1785e2316@pcow024o.blueyonder.co.uk>
Content-Type: text/plain; charset=US-ASCII
From: James A Sutherland <james@sutherland.net>
To: Thomas Hood <jdthood@mail.com>, linux-kernel@vger.kernel.org
Subject: Re: Oops - 2.4.17rc1 (with iptables 2.4.6)
Date: Sat, 15 Dec 2001 18:20:33 +0000
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <1008428030.4859.36.camel@thanatos>
In-Reply-To: <1008428030.4859.36.camel@thanatos>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 December 2001 2:53 pm, Thomas Hood wrote:
> It's interesting that you have the closed-source lt_modem
> driver loaded (and appears to have caused the oops) yet your
> oops log says "Not tainted".

Loading NVdriver doesn't taint my kernel, either. Something slightly screwy 
with the taint mechanism? Or an old version of insmod which doesn't check for 
tainting?


James.
