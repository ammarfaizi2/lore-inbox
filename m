Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272644AbTHKOqh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 10:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272692AbTHKOqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 10:46:37 -0400
Received: from pa186.opole.sdi.tpnet.pl ([213.76.204.186]:49141 "EHLO
	uran.deimos.one.pl") by vger.kernel.org with ESMTP id S272644AbTHKOma
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 10:42:30 -0400
Date: Mon, 11 Aug 2003 16:42:28 +0200
From: Damian Kolkowski <deimos@deimos.one.pl>
To: linux-kernel@vger.kernel.org
Subject: [BUG] - APCI lacks DRI performance.
Message-ID: <20030811144228.GA1202@deimos.one.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
X-Age: 23 (1980.09.27 - libra)
X-Girl: one will be enough!
X-IM: JID:dEiMoS_DK@jid.deimos.one.pl ICQ:59367544 GG:88988
X-Operating-System: Slackware GNU/Linux, kernel 2.4.22-rc2, up 3 min
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Using drivers from dri.sf.net for my rv250if (radeon-9000) is good idea, but
when I use APIC, the glxgears shows me _200 fps_ instead _1265 fps_ without
APIC in kernel.

Some ideas..?

Take care.

-- 
# Damian *dEiMoS* Ko³kowski # http://deimos.one.pl/ #
