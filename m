Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262532AbULDPL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262532AbULDPL1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 10:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbULDPL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 10:11:27 -0500
Received: from 82-147-17-1.dsl.uk.rapidplay.com ([82.147.17.1]:36664 "HELO
	short4.org") by vger.kernel.org with SMTP id S262532AbULDPL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 10:11:26 -0500
Message-ID: <41B1D385.2030904@linux-corner.info>
Date: Sat, 04 Dec 2004 15:11:01 +0000
From: Mark Watts <m.watts@linux-corner.info>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: getting performance statistics from the LVS subsystem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When you run a linux box as an LVS (Linux Virtual Server) director, what 
is the recomended way of getting performance statistics out of the kernel?

I'd like to run some tests on the LVS subsystem in order to work out its 
scaling limits on various hardware configurations, but I can't work out 
how to determine the kernels' load in response to the number of 
connection requests I put through it.

Cheers,

Mark.
