Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267064AbTGOKKz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 06:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267087AbTGOKKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 06:10:55 -0400
Received: from apate.telenet-ops.be ([195.130.132.57]:43479 "EHLO
	apate.telenet-ops.be") by vger.kernel.org with ESMTP
	id S267064AbTGOKKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 06:10:48 -0400
Date: Tue, 15 Jul 2003 12:27:43 +0200
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test1 some Problems (modules & touchpad)
Message-ID: <20030715102743.GB1685@viper.home.smets.cx>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
References: <3F13CF33.7040706@jstephan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <3F13CF33.7040706@jstephan.org>
User-Agent: Mutt/1.5.4i
From: jan@viper.home.smets.cx (Smets Jan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-07-15 11:53:55 (+0200), Joerg Stephan <joerg@jstephan.org> wrote:
> Hello everybody,
> 
> i've tried to run 2.6.0-test1 today on my acer aspire 1601lc, i've got 
> two Problems.
> 
> First of all, there is a problem with the modules (the same i had with 
> some versions of 2.5.x), see output below.
> 
> The second is, the touchpad of my notebook doesnt work.
> 
<snip>

I have the same problem with the touchpad on a dell inspiron 5000e,
Also having problems with Maestro 2E soundcard (ALSA).

There is also something weird going on with my pcmcia (CardBus TI PCI1225)
ethernet card (NE2000 compat),
but I have to look futher into it to tell for sure it isn't working.

Kernel was compiling just fine, and I was using module-init-tools
0.9.13-pre-1.

-- 
Smets Jan
jan@digibel.be

