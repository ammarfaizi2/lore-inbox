Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbTIBLDj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 07:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbTIBLDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 07:03:39 -0400
Received: from pa186.opole.sdi.tpnet.pl ([213.76.204.186]:7153 "EHLO
	uran.deimos.one.pl") by vger.kernel.org with ESMTP id S261162AbTIBLDi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 07:03:38 -0400
Date: Tue, 2 Sep 2003 13:03:35 +0200
From: Damian Kolkowski <deimos@deimos.one.pl>
To: linux-kernel@vger.kernel.org
Subject: [BUG] - 2.{4,6}.{22,0-test4} - CONFIG_X86_UP_APIC lack routing on eth
Message-ID: <20030902110335.GA540@deimos.one.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.4.1i
X-Age: 23 (1980.09.27 - libra)
X-Girl: one will be enough!
X-IM: JID:deimos@jid.deimos.one.pl ICQ:59367544 GG:88988
X-Operating-System: Slackware GNU/Linux, kernel 2.6.0-test4, up 0 min
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Kernels like 2.4.22 and 2.6.0-test4 (cset-455) with compiled in
CONFIG_X86_UP_APIC lacks the ehternet routing.

Take care.

P.S. It's on 2.4.22-ac1 and 2.4.22-ck1 too! But 2.4.22-rc2 has better APIC, so
good idea is to use it with -ac3 on that kernel.

PP.S. There is also radeonfb bug settings fonts and loadkeys only on
/dev/tty1.

-- 
# Damian *dEiMoS* Ko³kowski # http://deimos.one.pl/ #
