Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264172AbTH1Sry (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 14:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264188AbTH1Srx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 14:47:53 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:40941 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264172AbTH1Srw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 14:47:52 -0400
Date: Thu, 28 Aug 2003 11:16:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: isa0060/serio0 - where in sysfs?
Message-ID: <20030828091647.GB819@openzaurus.ucw.cz>
References: <E19mVQq-0003st-00.arvidjaar-mail-ru@f7.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19mVQq-0003st-00.arvidjaar-mail-ru@f7.mail.ru>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Should character devices appear in sysfs? I cannot see anything
> resembling the above there. Where does this name come from?

Input has its own hierarchy. It needs to be modified to work with sysfs.
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

