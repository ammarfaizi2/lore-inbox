Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263457AbTKJNE6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 08:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263461AbTKJNE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 08:04:58 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:46227 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S263457AbTKJNE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 08:04:57 -0500
Date: Mon, 10 Nov 2003 14:04:45 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test9-bk14: keyboard works ok now, but...
Message-ID: <20031110130445.GF23813@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Heath mad some changes to the keyboard driver and now my
keyboard finally works ok (Toshiba Satellite Pro 6100), but Ikeep
getting these:

Nov 10 13:13:28 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Nov 10 13:13:28 hummus2 input.agent[3516]: ... no modules for INPUT product 11/1/2/ab02
Nov 10 13:14:49 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Nov 10 13:14:49 hummus2 input.agent[3537]: ... no modules for INPUT product 11/1/2/ab02
Nov 10 13:19:24 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Nov 10 13:19:24 hummus2 input.agent[3841]: ... no modules for INPUT product 11/1/2/ab02
Nov 10 13:20:01 hummus2 input.agent[3862]: ... no modules for INPUT product 11/1/2/ab02
Nov 10 13:20:01 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Nov 10 13:20:58 hummus2 input.agent[3878]: ... no modules for INPUT product 11/1/2/ab02
Nov 10 13:20:58 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Nov 10 13:24:58 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Nov 10 13:24:58 hummus2 input.agent[3897]: ... no modules for INPUT product 11/1/2/ab02
Nov 10 13:35:26 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Nov 10 13:35:26 hummus2 input.agent[3984]: ... no modules for INPUT product 11/1/2/ab02
Nov 10 13:50:35 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Nov 10 13:50:35 hummus2 input.agent[4080]: ... no modules for INPUT product 11/1/2/ab02
Nov 10 13:58:04 hummus2 kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Nov 10 13:58:05 hummus2 input.agent[4153]: ... no modules for INPUT product 11/1/2/ab02

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
Referat V a - Kommunikationsnetze -             AIM.  ralfpostfix
