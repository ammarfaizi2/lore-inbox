Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271135AbUJVA1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271135AbUJVA1r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 20:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271157AbUJVA0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 20:26:25 -0400
Received: from dsl017-059-236.wdc2.dsl.speakeasy.net ([69.17.59.236]:29647
	"EHLO marta.kurtwerks.com") by vger.kernel.org with ESMTP
	id S271165AbUJVAQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 20:16:23 -0400
Date: Thu, 21 Oct 2004 20:22:37 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.9-rc?] long pause after IDE detection
Message-ID: <20041022002237.GA1948@kurtwerks.com>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
References: <20041021220438.GA13864@zombie.inka.de> <58cb370e0410211523416be4a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e0410211523416be4a8@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.9
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 12:23:34AM +0200, Bartlomiej Zolnierkiewicz took 8 lines to write:
> > CONFIG_IDE_GENERIC=y
> 
> Does disabling this option help?

Yes.

Kurt
-- 
It's no surprise that things are so screwed up: everyone that knows how
to run a government is either driving taxicabs or cutting hair.
	-- George Burns
