Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbVDEVfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbVDEVfg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 17:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbVDEVcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 17:32:55 -0400
Received: from smtp1.sloane.cz ([62.240.161.228]:53959 "EHLO smtp1.sloane.cz")
	by vger.kernel.org with ESMTP id S262052AbVDEVaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 17:30:21 -0400
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: My SWSUSP problems
Date: Tue, 5 Apr 2005 23:30:02 +0200
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504052330.02874.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There are some problems I have on my laptop using SWSUPS. This is it's 
summary:

1] When hibernate with different hw configuratin (USB devices, pcmcia 
devices), computer freezes imeditially after reading hibernate file from swap 
and after reset with hw configuration I had when hibernating, file is not 
readed again - data are lost - CRITICAL PROBLEM
2] When playing some OpenGL game or starting OpenGL application after 
hibernate, this app doesn't work till I kills X server. - tested on Intel 
852/855 Extreme graphics - for testing try for example glxgears - COMMON BUG

PLS let me know if these problems are solved or not and if are some developers 
interested about fixing them.

I use linux vanilla 2.6.11.6, Debian Testing, Acer TravelMate 240 serie

Michal
