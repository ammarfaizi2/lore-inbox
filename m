Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbTDCSbJ 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 13:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S261520AbTDCSbJ 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 13:31:09 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:55048 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S261504AbTDCSbF 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 13:31:05 -0500
Date: Thu, 3 Apr 2003 20:42:27 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Stuart MacDonald <stuartm@connecttech.com>
Cc: uclinux-dev@uclinux.org, linux-kernel@vger.kernel.org
Subject: Re: linux build process request
Message-ID: <20030403184227.GA1027@mars.ravnborg.org>
Mail-Followup-To: Stuart MacDonald <stuartm@connecttech.com>,
	uclinux-dev@uclinux.org, linux-kernel@vger.kernel.org
References: <200304011308.15196.tendim@tendim.cjb.net> <200304012258.47696.tendim@tendim.cjb.net> <010501c2fa07$7dee9ce0$294b82ce@connecttech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010501c2fa07$7dee9ce0$294b82ce@connecttech.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 12:36:00PM -0500, Stuart MacDonald wrote:
> 
> Something I'd like to see is a "make help" or "make targets" target
> that would simply echo out the list of available targets in the linux
> kernel build process and a description of what each one does.

"make help" is already available in 2.5.
It includes an architecture specific section, which most (but not all)
architectures define.

	Sam
