Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318838AbSHWPdM>; Fri, 23 Aug 2002 11:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318857AbSHWPdM>; Fri, 23 Aug 2002 11:33:12 -0400
Received: from pD9E2385F.dip.t-dialin.net ([217.226.56.95]:29593 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318838AbSHWPdL>; Fri, 23 Aug 2002 11:33:11 -0400
Date: Fri, 23 Aug 2002 09:37:22 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Holger Schurig <h.schurig@mn-logistik.de>
cc: Jan Harkes <jaharkes@cs.cmu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: cell-phone like keyboard driver anywhere?
In-Reply-To: <200208231710.19950.h.schurig@mn-logistik.de>
Message-ID: <Pine.LNX.4.44.0208230933230.3234-100000@hawkeye.luckynet.adm>
X-Location: Potsdam-Babelsberg; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 23 Aug 2002, Holger Schurig wrote:
> But what if the computer is used for tn-5250 (ncurses), Konq/Embedded
> (Qt/Embedded) and Java (X11), just as the user pleases?  In this case
> you need something general, and that usually means a kernel driver

The problem is that most cell phones, if they don't have a keyboard 
themselves, only have 16 keys (0 through 9, *, #, cancel, menu, up/down). 
My cellphonish pocket terminal got its own space-cadet derived keyboard, 
works well. But I don't really thing you'll cope w/only 16 keys.

Otherwise proceed the ugly way it is. 0 through 9 have their usual 
meaning, all the multicodes, menu is say return, C is esc, up/down - well, 
ok, and * and # have any meaning. I see no better way.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

