Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWCONOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWCONOR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 08:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbWCONOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 08:14:17 -0500
Received: from ns1.suse.de ([195.135.220.2]:21901 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751135AbWCONOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 08:14:17 -0500
From: Andreas Schwab <schwab@suse.de>
To: Stefan Seyfried <seife@suse.de>
Cc: Denis Vlasenko <vda@ilport.com.ua>, linux-kernel@vger.kernel.org,
       christiand59@web.de
Subject: Re: /dev/stderr gets unlinked 8]
References: <200603141213.00077.vda@ilport.com.ua>
	<200603141411.11121.christiand59@web.de>
	<200603141535.57978.vda@ilport.com.ua>
	<20060315110252.GB31317@suse.de>
X-Yow: Do you need any MOUTH-TO-MOUTH resuscitation?
Date: Wed, 15 Mar 2006 14:14:15 +0100
In-Reply-To: <20060315110252.GB31317@suse.de> (Stefan Seyfried's message of
	"Wed, 15 Mar 2006 12:02:52 +0100")
Message-ID: <jehd5zq28o.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Seyfried <seife@suse.de> writes:

> any good daemon closes stdout, stderr, stdin

A real good daemon would redirect them to /dev/null.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
