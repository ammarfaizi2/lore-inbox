Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264197AbTF0L1n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 07:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbTF0L1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 07:27:43 -0400
Received: from robur.slu.se ([130.238.98.12]:44552 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id S264190AbTF0L1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 07:27:40 -0400
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16124.11592.136156.61126@robur.slu.se>
Date: Fri, 27 Jun 2003 13:40:56 +0200
To: "Adam Flizikowski" <adam_fli@poczta.onet.pl>
Cc: <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>
Subject: How to do kernel packet forwarding performance analysys - please comment on my method 
In-Reply-To: <GMEGLMHAELFDACHHIEPIMEBGCFAA.adam_fli@poczta.onet.pl>
References: <GMEGLMHAELFDACHHIEPIMEBGCFAA.adam_fli@poczta.onet.pl>
X-Mailer: VM 6.92 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adam Flizikowski writes:
 > 
 > Hello,
 > 
 > I want to analyze how much time is spent on forwarding process in linux
 > kernel.
 > 
 > This is second post but the matter is very important to me. I am dealing
 > with this for few months now.
 
 Hello!
 "time spent on forwarding" is very vague. Raw forwarding capacity use 
 to be measured in pps (packets per second) and it depends on many things
 beside hardware as packet size, routing table size, new flows/s etc.

 You can look at (o)profiles during forwarding.

 Cheers.
						--ro
