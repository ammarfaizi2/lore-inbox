Return-Path: <linux-kernel-owner+w=401wt.eu-S1762600AbWLKVWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762600AbWLKVWH (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 16:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763080AbWLKVWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 16:22:06 -0500
Received: from polish-dvd.com ([69.222.0.225]:37267 "HELO
	mail.webhostingstar.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1762600AbWLKVWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 16:22:05 -0500
Message-ID: <20061211151204.gz85ndgoe2o0ccws@69.222.0.225>
Date: Mon, 11 Dec 2006 15:12:04 -0600
From: art@usfltd.com
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: 2.6.19-git problem - dvd+rw-usb - :-( not an MMC unit!
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.1.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to: linux-kernel@vger.kernel.org
cc: torvalds@osdl.org

2.6.19-git problem - dvd+rw-usb - :-( not an MMC unit!

same pc
$ uname -r
2.6.18-1.2849.fc6
$ dvd+rw-mediainfo /dev/dvd-sr0
INQUIRY:                [SONY    ][DVD RW DRU-820A ][2.0b]
GET [CURRENT] CONFIGURATION:
:-( no media mounted, exiting...
$

$uname -a
Linux xxx.xxx 2.6.19-200612110945-g9202f325 #21 SMP PREEMPT Mon Dec 11  
09:48:52 CST 2006 x86_64 x86_64 x86_64 GNU/Linux
$ dvd+rw-mediainfo /dev/dvd-sr0
:-( not an MMC unit!
$

any clue?

xboom
