Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268848AbUJTSue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268848AbUJTSue (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 14:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268846AbUJTSt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 14:49:58 -0400
Received: from smtp1.sloane.cz ([62.240.161.228]:5585 "EHLO smtp1.sloane.cz")
	by vger.kernel.org with ESMTP id S268991AbUJTSpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 14:45:34 -0400
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: Hibernation and time and dhcp
Date: Wed, 20 Oct 2004 20:45:24 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410202045.24388.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

with 2.6.9 hibernation to disk finally works! Thanks
To ram it still don't work, system starts with lcd disabled - but it is 
another story.

I have now this problem - when I hibernate and then system is started up in 
other company, it don't update time and shows still for example 14:00 - when 
I rehibernate for example in 20:00 - could you ask bios for current time? 
It's better to have bad time about few seconds instead of hours.

Same problem with dhcp - it should ask for IP when rehibernate.

Thanks for fixing

Michal
