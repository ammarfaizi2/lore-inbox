Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272009AbTG1CBb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 22:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271033AbTG1ABI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:01:08 -0400
Received: from ss1000.ms.mff.cuni.cz ([195.113.19.221]:37598 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S272682AbTG0XUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:20:00 -0400
Date: Mon, 28 Jul 2003 01:35:06 +0200
From: Rudo Thomas <thomr9am@ss1000.ms.mff.cuni.cz>
To: Balram Adlakha <b_adlakha@softhome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2 OSS emu10k1
Message-ID: <20030728013506.A29614@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: Balram Adlakha <b_adlakha@softhome.net>,
	linux-kernel@vger.kernel.org
References: <20030727190257.GA2840@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030727190257.GA2840@localhost.localdomain>; from b_adlakha@softhome.net on Mon, Jul 28, 2003 at 12:32:57AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I cannot compile the emu10k1 module:
> 
> sound/oss/emu10k1/hwaccess.c:182: redefinition of `emu10k1_writefn0_2'
> sound/oss/emu10k1/hwaccess.c:164: `emu10k1_writefn0_2' previously defined here

You screwed up somehow, I see only one definition of that function in 2.6.0-test2...

Rudo.
