Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263523AbTDMOai (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 10:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263525AbTDMOai (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 10:30:38 -0400
Received: from dsl081-067-005.sfo1.dsl.speakeasy.net ([64.81.67.5]:6356 "EHLO
	renegade") by vger.kernel.org with ESMTP id S263523AbTDMOag (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 10:30:36 -0400
Date: Sun, 13 Apr 2003 07:42:18 -0700
From: Zack Brown <zbrown@tumblerings.org>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lk-changelog.pl 0.96
Message-ID: <20030413144218.GB21855@renegade>
References: <20030413104943.433A37EBE4@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030413104943.433A37EBE4@merlin.emma.line.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 13, 2003 at 12:49:43PM +0200, Matthias Andree wrote:
> This is a semi-automatic announcement.
> 
> lk-changelog.pl aka. shortlog version 0.96 has been released.

I think these emails from Alan and Linus actually appear in changelogs.

Be well,
Zack

--- lk-changelog-0.96.pl	2003-04-13 07:24:56.000000000 -0700
+++ lk-changelog-0.96.pl.zb	2003-04-13 07:33:58.000000000 -0700
@@ -128,6 +128,8 @@
 'akpm:reardensteel.com' => 'Andrew Morton',
 'akpm:zip.com.au' => 'Andrew Morton',
 'akropel1:rochester.rr.com' => 'Adam Kropelin', # lbdb
+'alan:hraefn.swansea.linux.org.uk' => 'Alan Cox',
+'alan:irongate.swansea.linux.org.uk' => 'Alan Cox',
 'alan:lxorguk.ukuu.org.uk' => 'Alan Cox',
 'alan:redhat.com' => 'Alan Cox',
 'alex:ssi.bg' => 'Alexander Atanasov',
@@ -352,8 +354,8 @@
 'erik:aarg.net' => 'Erik Arneson',
 'erik_habbinga:hp.com' => 'Erik Habbinga',
 'eyal:eyal.emu.id.au' => 'Eyal Lebedinsky', # lbdb
-'falk.hueffner:student.uni-tuebingen.de' => 'Falk Hüffner',
 'faikuygur:ttnet.net.tr' => 'Faik Uygur',
+'falk.hueffner:student.uni-tuebingen.de' => 'Falk Hüffner',
 'fbl:conectiva.com.br' => 'Flávio Bruno Leitner', # google
 'fdavis:si.rr.com' => 'Frank Davis',
 'felipewd:terra.com.br' => 'Felipe Damasio', # by self (did not ask to include the W.)
@@ -946,7 +948,13 @@
 'tomlins:cam.org' => 'Ed Tomlinson',
 'tony.luck:intel.com' => 'Tony Luck',
 'tony:cantech.net.au' => 'Anthony J. Breeds-Taurima',
+'torvalds:athlon.transmeta.com' => 'Linus Torvalds',
+'torvalds:home.transmeta.com' => 'Linus Torvalds',
+'torvalds:kiwi.transmeta.com' => 'Linus Torvalds',
 'torvalds:linux.local' => 'Linus Torvalds',
+'torvalds:penguin.transmeta.com' => 'Linus Torvalds',
+'torvalds:tove.transmeta.com' => 'Linus Torvalds',
+'torvalds:transmeta.com' => 'Linus Torvalds',
 'trevor.pering:intel.com' => 'Trevor Pering',
 'trini:bill-the-cat.bloom.county' => 'Tom Rini',
 'trini:kernel.crashing.org' => 'Tom Rini',

-- 
Zack Brown
