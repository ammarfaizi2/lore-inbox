Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272536AbTHEQYb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 12:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272551AbTHEQYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 12:24:31 -0400
Received: from poup.poupinou.org ([195.101.94.96]:6406 "EHLO poup.poupinou.org")
	by vger.kernel.org with ESMTP id S272536AbTHEQYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 12:24:30 -0400
Date: Tue, 5 Aug 2003 18:24:28 +0200
To: Tomas Szepe <szepe@pinerecords.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL] sanitize power management config menus, take two
Message-ID: <20030805162428.GB1511@poupinou.org>
References: <20030805072631.GC5876@louise.pinerecords.com> <20030805161117.GA1511@poupinou.org> <20030805161505.GD18982@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030805161505.GD18982@louise.pinerecords.com>
User-Agent: Mutt/1.5.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 06:15:05PM +0200, Tomas Szepe wrote:

> o  only enable cpufreq options if power management is selected
> o  don't put cpufreq options in a separate submenu

Yes, but what I do not understand is why cpufreq need power management.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
