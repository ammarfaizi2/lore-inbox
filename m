Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262691AbVGHPvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbVGHPvV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 11:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbVGHPvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 11:51:20 -0400
Received: from cantor2.suse.de ([195.135.220.15]:698 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262691AbVGHPvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 11:51:20 -0400
Message-ID: <42CE8005.8020108@suse.de>
Date: Fri, 08 Jul 2005 15:30:45 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050322 Thunderbird/1.0.2 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: linux-kernel@vger.kernel.org, ncunningham@cyclades.com
Subject: Re: [0/48] Suspend2 2.1.9.8 for 2.6.12
References: <11206164393426@foobar.com> <20050706082230.GF1412@elf.ucw.cz> <20050706082230.GF1412@elf.ucw.cz> <1120696047.4860.525.camel@localhost> <E1DqV7G-0004PX-00@chiark.greenend.org.uk> <E1DqV7G-0004PX-00@chiark.greenend.org.uk> <1120738525.4860.1433.camel@localhost> <E1DqVp3-00064l-00@chiark.greenend.org.uk>
In-Reply-To: <E1DqVp3-00064l-00@chiark.greenend.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett wrote:

> Right, so you support the resume from disk trigger in sysfs and the
> /proc/acpi/sleep interface? If suspend2 is a complete dropin replacement
> then I'm much happier with the idea of dropping swsusp, but I don't want
> to have to tie suspend/resume scripts to kernel versions.

JFTR: i second this. There is already enough hackery involved if one
wants to provide a smooth user experience ;-)
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen

