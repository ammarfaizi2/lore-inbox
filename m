Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262843AbRFCLSr>; Sun, 3 Jun 2001 07:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262873AbRFCLSh>; Sun, 3 Jun 2001 07:18:37 -0400
Received: from inje.iskon.hr ([213.191.128.16]:44490 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S262843AbRFCLOF>;
	Sun, 3 Jun 2001 07:14:05 -0400
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: XMM: monitor Linux MM inactive/active lists graphically
In-Reply-To: <01060222320301.23925@oscar>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: 03 Jun 2001 13:13:51 +0200
In-Reply-To: <01060222320301.23925@oscar> (Ed Tomlinson's message of "Sat, 2 Jun 2001 22:32:03 -0400")
Message-ID: <87d78lolxs.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Copyleft)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson <tomlins@cam.org> writes:

> Zlatko,
> 
> Do you have your modified xmem available somewhere.  Think it might be of
> interest to a few of us.
> 
> TIA
> Ed Tomlinson <tomlins@cam.org>
> 

For some time I've been trying to make a simple, yet functional web
page to put some stuff there. But, HTML hacking and kernel hacking are
such a different beasts... :)

XMM is heavily modified XMEM utility that shows graphically size of
different Linux page lists: active, inactive_dirty, inactive_clean,
code, free and swap usage. It is better suited for the monitoring of
Linux 2.4 MM implementation than original (XMEM) utility.

Find it here:  <URL:http://linux.inet.hr/>

-- 
Zlatko

P.S. I'm gladly accepting suggestion for a simple tool that would help
in static web site creation/development. I checked genpage, htmlmake
and some other utilities but in every of them I found something that I
didn't like. Tough job, that HTML authoring.
