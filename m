Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264117AbUECWjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264117AbUECWjQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 18:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbUECWjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 18:39:16 -0400
Received: from palrel10.hp.com ([156.153.255.245]:3978 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S264117AbUECWjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 18:39:15 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16534.51724.578183.845357@napali.hpl.hp.com>
Date: Mon, 3 May 2004 15:39:08 -0700
To: arjanv@redhat.com
Cc: davidm@hpl.hp.com, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, bunk@fs.tum.de, eyal@eyal.emu.id.au,
       linux-dvb-maintainer@linuxtv.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3: modular DVB tda1004x broken
In-Reply-To: <1083618424.3843.12.camel@laptop.fenrus.com>
References: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org>
	<408F9BD8.8000203@eyal.emu.id.au>
	<20040501201342.GL2541@fs.tum.de>
	<Pine.LNX.4.58.0405011536300.18014@ppc970.osdl.org>
	<20040501161035.67205a1f.akpm@osdl.org>
	<Pine.LNX.4.58.0405011653560.18014@ppc970.osdl.org>
	<20040501175134.243b389c.akpm@osdl.org>
	<16534.35355.671554.321611@napali.hpl.hp.com>
	<Pine.LNX.4.58.0405031336470.1589@ppc970.osdl.org>
	<16534.45589.62353.878714@napali.hpl.hp.com>
	<1083618424.3843.12.camel@laptop.fenrus.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 03 May 2004 23:07:04 +0200, Arjan van de Ven <arjanv@redhat.com> said:

  Arjan> Exporting sys_mlock() for a kernel module soooo sounds wrong
  Arjan> to me

On what grounds?  What alternative are you suggesting?

	--david
