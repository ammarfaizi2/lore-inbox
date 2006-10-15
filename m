Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422880AbWJOTtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422880AbWJOTtP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 15:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422885AbWJOTtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 15:49:15 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:51600 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1422880AbWJOTtO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 15:49:14 -0400
Message-ID: <453290B6.4010704@drzeus.cx>
Date: Sun, 15 Oct 2006 21:49:10 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: Philip Langdale <philipl@overt.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18 1/1] mmc: Add support for mmc v4 high speed mode
References: <21173.67.169.45.37.1159940502.squirrel@overt.org>    <452B3B00.5080209@drzeus.cx> <11208.67.169.45.37.1160545100.squirrel@overt.org> <452C87FB.6080302@drzeus.cx> <452C965A.6020409@overt.org>
In-Reply-To: <452C965A.6020409@overt.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philip Langdale wrote:
> Correct. SWITCH is used to change the bus width. Now I have to stop
> avoiding the issue and confront those crazy test commands so we can turn
> on the wide-bus stuff properly. (You are happy with this diff now right? :-)
>   

That I am. It will be queued up for 2.6.20 once I get my new maintainer
role in order.

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
  OLPC, developer                     http://www.laptop.org

