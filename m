Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759184AbWLAOcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759184AbWLAOcZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 09:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759305AbWLAOcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 09:32:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:55744 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1759184AbWLAOcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 09:32:24 -0500
Subject: Re: [PATCH 1/4] [x86] Add command line option to enable/disable
	hyper-threading.
From: Arjan van de Ven <arjan@infradead.org>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
In-Reply-To: <1164980500.5257.922.camel@gullible>
References: <11648607683157-git-send-email-bcollins@ubuntu.com>
	 <11648607733630-git-send-email-bcollins@ubuntu.com>
	 <20061201132918.GB4239@ucw.cz>  <1164980500.5257.922.camel@gullible>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 01 Dec 2006 15:32:08 +0100
Message-Id: <1164983529.3233.73.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> The idea is that we want our users to be able to use hyper-threading,
> but we don't want it on by default.

Hi,

can I ask why not?

Greetings,
   Arjan van de Ven
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

