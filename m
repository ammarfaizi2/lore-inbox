Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262416AbVAUQdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbVAUQdH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 11:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbVAUQdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 11:33:07 -0500
Received: from mta.songnetworks.no ([62.73.241.54]:43444 "EHLO
	pebbles.fastcom.no") by vger.kernel.org with ESMTP id S262416AbVAUQcu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 11:32:50 -0500
Mime-Version: 1.0 (Apple Message framework v619)
Content-Transfer-Encoding: 7bit
Message-Id: <18D4A39C-6BCA-11D9-9476-000D932A43BC@karlsbakk.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-kernel@vger.kernel.org
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Subject: system load avg loops?!?
Date: Fri, 21 Jan 2005 17:32:52 +0100
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hei

the log at http://karlsbakk.net/uptime.log.gz is a log create with

while true
do
	uptime >> log
done

this shows the system load is somehow looping?!?

the system behaves well and is in production, but I don't really 
understand what the kernel is up to. same numbers are reported by top. 
sar and top etc reports no or little cpu and I/O load (<3%). The system 
is used as a general tools server doing some webserver, nagios and mrtg 
stuff. System is running 2.6.9-mm1.

please cc: to me as I'm not on the list

roy

