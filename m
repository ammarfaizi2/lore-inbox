Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264683AbTANPty>; Tue, 14 Jan 2003 10:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264688AbTANPtN>; Tue, 14 Jan 2003 10:49:13 -0500
Received: from pD9E103E1.dip.t-dialin.net ([217.225.3.225]:65004 "EHLO fefe.de")
	by vger.kernel.org with ESMTP id <S264644AbTANPrz>;
	Tue, 14 Jan 2003 10:47:55 -0500
Date: Tue, 14 Jan 2003 04:09:32 +0100
From: Felix von Leitner <felix-linuxkernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: rivafb still broken in 2.5.59
Message-ID: <20030114030932.GA1417@fefe.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using a Geforce 4 Ti 4200, and with great joy I saw that recent 2.5
kernels actually recognize the PCI IDs of this card, so I tried the
module again.

And indeed, my screen went blank, and then started looking like a whole
lot of tiny moose droppings.  I can log in, I can run ls -l, and I can
see motion, but that's about it.  I write this because rivafb has been
broken for months now (also on my notebook with Geforce2 Go), and it is
now broken in a different way, so I thought I'd mention it, since
someone appears to be working on it.

You know, it would help a lot if that someone would publish his email
address somewhere.

Felix
