Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290803AbSBFUoQ>; Wed, 6 Feb 2002 15:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290802AbSBFUoG>; Wed, 6 Feb 2002 15:44:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57362 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290795AbSBFUnw>;
	Wed, 6 Feb 2002 15:43:52 -0500
Message-ID: <3C619586.92EAED50@mandrakesoft.com>
Date: Wed, 06 Feb 2002 15:43:50 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Applying 2.5.4-pre1 patch
In-Reply-To: <3C6119E2.2060504@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Rousselet wrote:
> 
> Patching drivers/char/gameport with /dev/null doesn't work for me. What
> is the trick ?

/dev/null indicates a new, or a removed, file.

-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
