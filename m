Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263270AbSKTXHI>; Wed, 20 Nov 2002 18:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263279AbSKTXHI>; Wed, 20 Nov 2002 18:07:08 -0500
Received: from cygnus-ext.enyo.de ([212.9.189.162]:47620 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id <S263270AbSKTXHH>;
	Wed, 20 Nov 2002 18:07:07 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.23-rc2
References: <200211201628.gAKGSwL03853@devserv.devel.redhat.com>
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Thu, 21 Nov 2002 00:14:12 +0100
In-Reply-To: <200211201628.gAKGSwL03853@devserv.devel.redhat.com> (Alan
 Cox's message of "Wed, 20 Nov 2002 17:40:08 +0100")
Message-ID: <87wun796m3.fsf@deneb.enyo.de>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@redhat.com> writes:

> Actually include the DoS fix this time

But doesn't seem to include the TCP "SYN with RST isn't a SYN, really"
fix. ;-)
