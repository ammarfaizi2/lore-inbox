Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVGYHTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVGYHTZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 03:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVGYHTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 03:19:17 -0400
Received: from mx1.suse.de ([195.135.220.2]:46541 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261196AbVGYHR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 03:17:56 -0400
Message-ID: <42E4890C.2010801@suse.de>
Date: Mon, 25 Jul 2005 08:39:08 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.9) Gecko/20050712 Thunderbird/1.0.5 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
       Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Subject: Re: [PATCH] reset VGA adapters via BIOS on resume... (non-fbdev/con)
References: <Pine.LNX.4.58.0507221942540.5475@skynet> <E1Dw6lc-0007IU-00@chiark.greenend.org.uk> <E1Dw6lc-0007IU-00@chiark.greenend.org.uk> <20050723003140.GB1988@elf.ucw.cz> <E1Dw80M-0001EG-00@chiark.greenend.org.uk> <20050723004745.GA7868@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20050723004745.GA7868@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

> Anyway, this patch is really good, and enables S3 to work on more
> machines. Thats good. It is not intrusive and I'll probably (try to)
> push it.

which acpi_sleep=... parameter enables it? I have machines resuming
perfectly fine without it that i don't want to break ;-)
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen

