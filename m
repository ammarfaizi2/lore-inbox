Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262144AbVERKho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbVERKho (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 06:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbVERKhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 06:37:43 -0400
Received: from ns.inescn.pt ([192.35.246.1]:59601 "EHLO animal.inescn.pt")
	by vger.kernel.org with ESMTP id S262144AbVERKfk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 06:35:40 -0400
Message-ID: <428B1A60.6030505@inescporto.pt>
Date: Wed, 18 May 2005 11:35:12 +0100
From: Filipe Abrantes <fla@inescporto.pt>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Detecting link up
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I need to detect when an interface (wired ethernet) has link up/down. Is 
there a system signal which is sent when this happens? What is the best 
way to this programatically?

Best Regards

Filipe


-- 
Filipe Lameiro Abrantes
INESC Porto
Campus da FEUP
Rua Dr. Roberto Frias, 378
4200-465 Porto
Portugal

Phone: +351 22 209 4266
E-mail: fla@inescporto.pt
