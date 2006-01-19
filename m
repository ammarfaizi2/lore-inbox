Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161169AbWASKNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161169AbWASKNi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 05:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161225AbWASKNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 05:13:38 -0500
Received: from wavehammer.waldi.eu.org ([82.139.196.55]:15319 "EHLO
	wavehammer.waldi.eu.org") by vger.kernel.org with ESMTP
	id S1161169AbWASKNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 05:13:37 -0500
Date: Thu, 19 Jan 2006 11:13:31 +0100
From: Bastian Blank <waldi@debian.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: maximilian attems <maks@sternwelten.at>,
       Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] kbuild: add automatic updateconfig target
Message-ID: <20060119101331.GB27042@wavehammer.waldi.eu.org>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
	maximilian attems <maks@sternwelten.at>,
	Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <20060118194056.GA26532@nancy> <20060118204234.GC14340@mars.ravnborg.org> <20060118204750.GD14340@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060118204750.GD14340@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 09:47:50PM +0100, Sam Ravnborg wrote:
> > Keep same naming as the others. May I suggest set_default.

set_* is something different. It uses the default config, not the actual
one.

Bastian

-- 
Those who hate and fight must stop themselves -- otherwise it is not stopped.
		-- Spock, "Day of the Dove", stardate unknown
