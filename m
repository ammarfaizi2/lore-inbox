Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265657AbUAGW0e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 17:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265660AbUAGW0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 17:26:34 -0500
Received: from mxout.iskon.hr ([213.191.128.10]:55777 "HELO mxout.iskon.hr")
	by vger.kernel.org with SMTP id S265657AbUAGW0d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 17:26:33 -0500
X-Remote-IP: 213.191.139.250
To: linux-kernel@vger.kernel.org
Subject: iostat - Linux I/O performance monitoring utility
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: Wed, 07 Jan 2004 23:26:21 +0100
Message-ID: <87znczfl9u.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

iostat v2.0 is out!

It works flawlessly on both 2.4 & 2.6, compiles on Debian, Redhat, you
name it... IOW, it's perfect. :)

Looks something like this:

                             extended device statistics                       
device mgr/s mgw/s    r/s    w/s    kr/s    kw/s   size queue   wait svc_t  %b 
hde        0  3530    5.0   92.0    20.2 14597.8  150.6  68.1  563.2   6.0  58 
hdg        0     0    0.0    0.0     0.0     0.0    0.0   0.0    0.0   0.0   0 
hda        0   105  159.6   69.4   637.7   812.9    6.3  56.0  176.4   4.1  95 

Find it on:  http://linux.inet.hr/

Comments welcome, please Cc: me 'cause I'm not subscribed.
-- 
Zlatko
