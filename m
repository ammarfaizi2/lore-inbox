Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbTLUBZj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 20:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTLUBZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 20:25:39 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:48814 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262130AbTLUBZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 20:25:34 -0500
Date: Sun, 21 Dec 2003 02:25:31 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Fw: 2.6.0-test11 BK: sg and scanner modules not auto-loaded?
Message-ID: <20031221012531.GB30123@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <20031219181039.GI3017@kroah.com> <20031221003020.63E6A2C0B8@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031221003020.63E6A2C0B8@lists.samba.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Dec 2003, Rusty Russell wrote:

> It's been argued that kmod should place a request with the hotplug
> subsystem, rather than call modprobe, but that's a little too radical
> for me just yet.

Hotplug works for 2.4, I don't know what is different in 2.6 - are there
hotplug relevant kernel changes? Stupid question maybe, but I'm asking
nonetheless :-)

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
