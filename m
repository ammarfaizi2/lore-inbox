Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263764AbTJCPyh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 11:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263765AbTJCPyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 11:54:37 -0400
Received: from [62.67.222.139] ([62.67.222.139]:46532 "EHLO mail.ku-gbr.de")
	by vger.kernel.org with ESMTP id S263764AbTJCPyg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 11:54:36 -0400
Date: Fri, 3 Oct 2003 17:54:59 +0200
From: Konstantin Kletschke <konsti@ludenkalle.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Date/UnixTime of SysRq state dump
Message-ID: <20031003155459.GA4025%konsti@ludenkalle.de>
Reply-To: Konstantin Kletschke <konsti@ludenkalle.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20031001182859.GA4081%konsti@ludenkalle.de> <20031001162141.278442d7.akpm@osdl.org> <20031002091638.GA15471@synertronixx3>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031002091638.GA15471@synertronixx3>
Organization: Kletschke & Uhlig GbR
User-Agent: Mutt/1.5.4i-ja.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Konstantin Kletschke <konsti@ludenkalle.de> [Thu, Oct 02, 2003 at 11:16:38AM +0200]:

> OK, I will keep an eye on it. Poorly I upgraded Kernel and mpd after

Ok, the freeze at day change was random, a pure hoax of my PC! This time
it happened at 17:35 somehow.

Sadly this fｧ"$% minicom trunkated the state dump at top while my pc
rebootet :-( STOP, it is not trunkated, one sees the Show State command
at the first line :)

Andrew, the mpd tasks are still in there, may be you recognize a
similair pattern in its state or even not, one knows more then...

Again, this one

http://ludenkalle.de/capture-2003-10-03.log

is tainted. _Now_ I am back at nv driver and one screen instead of too
:(. Is there any XFree86 os driver supporting two screen output on a
Graphics Card which has two Outputs?

Regards, Konsti

-- 
2.6.0-test6-mm1
Konstantin Kletschke <konsti@ludenkalle.de>, <konsti@ku-gbr.de>
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
keulator.homelinux.org up 12 min, 
