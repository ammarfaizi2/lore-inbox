Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317998AbSGRGHY>; Thu, 18 Jul 2002 02:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318015AbSGRGHY>; Thu, 18 Jul 2002 02:07:24 -0400
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:16780 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S317998AbSGRGHX>; Thu, 18 Jul 2002 02:07:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: "Pierre ROUSSELET" <pierre.rousselet@wanadoo.fr>, <greg@kroah.com>
Subject: Re: 2.5.25  uhci-hcd  very bad
Date: Thu, 18 Jul 2002 08:10:13 +0200
User-Agent: KMail/1.4.2
Cc: <linux-kernel@vger.kernel.org>
References: <3D308A30.7070702@wanadoo.fr> <20020717213332.GA10227@kroah.com> <3D2A7916004B5024@mel-rta10.wanadoo.fr> (added by     postmaster@wanadoo.fr)
In-Reply-To: <3D2A7916004B5024@mel-rta10.wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207180810.13692.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 July 2002 08:35, Pierre ROUSSELET wrote:
> The driver is made of a kernel module speedtch.o (built outside of the
> tree) and of userspace modem firmware loader and management daemon
> speedmgt.

Is your kernel preemptive?

Duncan.
