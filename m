Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266037AbUA1Til (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 14:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266132AbUA1Til
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 14:38:41 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:64522 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S266037AbUA1Tik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 14:38:40 -0500
Date: Wed, 28 Jan 2004 20:45:49 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: some combinations of make targets do not work anymore
Message-ID: <20040128194549.GB2695@mars.ravnborg.org>
Mail-Followup-To: Olaf Hering <olh@suse.de>,
	linux-kernel@vger.kernel.org
References: <20040128180111.GA23021@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040128180111.GA23021@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 07:01:11PM +0100, Olaf Hering wrote:
> 
> Stuff like that used to work with 2.4 kernels, 2.6.2-rc2-mm2 runs make
> oldconfig and depmod, but 'all' and 'modules_install' is not executed.
> Bug or feature? target is ppc32.

Unexpected to say it. I have noticed some time ago, but since noone complained...
I will take a look.

	Sam
