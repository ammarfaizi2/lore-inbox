Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbULKVO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbULKVO3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 16:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbULKVO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 16:14:29 -0500
Received: from zork.zork.net ([64.81.246.102]:24487 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S262009AbULKVO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 16:14:27 -0500
From: Sean Neakums <sneakums@zork.net>
To: "Camilo A. Reyes" <camilo@leamonde.no-ip.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: modprobe: QM_MODULES: Funtion not implemented on kernel 2.6.9
References: <20041211195133.GA2210@leamonde.no-ip.org>
Mail-Followup-To: "Camilo A. Reyes" <camilo@leamonde.no-ip.org>,
	linux-kernel@vger.kernel.org
Date: Sat, 11 Dec 2004 21:14:15 +0000
In-Reply-To: <20041211195133.GA2210@leamonde.no-ip.org> (Camilo A. Reyes's
	message of "Sat, 11 Dec 2004 13:51:33 -0600")
Message-ID: <6uvfb8leqg.fsf@zork.zork.net>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Camilo A. Reyes" <camilo@leamonde.no-ip.org> writes:

> Not sure if this has been raised before, but I get this error message
> every time I try to load a module, it is not the modprobe program it self
> causing the problem since I updated it to version 2.4.9 which is the
> latest out there...

For Linux 2.6 you will need the module-init-tools package.
