Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262313AbTCRL1n>; Tue, 18 Mar 2003 06:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262344AbTCRL1n>; Tue, 18 Mar 2003 06:27:43 -0500
Received: from web40512.mail.yahoo.com ([66.218.78.129]:7981 "HELO
	web40512.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262313AbTCRL1n>; Tue, 18 Mar 2003 06:27:43 -0500
Message-ID: <20030318113833.18746.qmail@web40512.mail.yahoo.com>
Date: Tue, 18 Mar 2003 03:38:33 -0800 (PST)
From: Stih Frenks <frenkstih@yahoo.com>
Subject: Strange thing about ip_forward, is it a bug maybe?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have following situation:

PC1    ---------   PC2    --------- PC3
eth0               eth0           eth1
                   eth1

on PC2 ip_forward = 0. 

If I now try to ping from PC3 to PC2 eth0 I can ping
it, also the most dangerous I can telnet to eth0 even
if ip_forward is 0. Am I missing something or what is
wrong here ???

Thanks for the answer, Frenk

__________________________________________________
Do you Yahoo!?
Yahoo! Platinum - Watch CBS' NCAA March Madness, live on your desktop!
http://platinum.yahoo.com
