Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265666AbTGCJTR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 05:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265607AbTGCJTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 05:19:16 -0400
Received: from pa186.opole.sdi.tpnet.pl ([213.76.204.186]:50934 "EHLO
	uran.deimos.one.pl") by vger.kernel.org with ESMTP id S265666AbTGCJSg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 05:18:36 -0400
Date: Thu, 3 Jul 2003 11:32:21 +0200
From: Damian Kolkowski <deimos@deimos.one.pl>
To: linux-kernel@vger.kernel.org
Cc: Ani Joshi <ajoshi@kernel.crashing.org>
Subject: [BUG] - 2.5.74 - (frame buffer & radeonfb) - no setfont, loadkeys on all tty
Message-ID: <20030703093221.GA1032@deimos.one.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
X-Age: 23 (1980.09.27 - libra)
X-Girl: one will be enough!
X-IM: JID:dEiMoS_DK@jabber.org ICQ:59367544 GG:88988
X-Operating-System: Slackware GNU/Linux, kernel 2.5.74, up 2 min
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have radeon rv250if, so on that card using radeonfb there is no local font
setting on all tty; only on first tty1.

Using SVGATextMode fonts and maps are loading right.

Take care.

-- 
# Damian *dEiMoS* Ko³kowski # http://deimos.one.pl/ #
