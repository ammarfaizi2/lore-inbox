Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263060AbVAFXOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263060AbVAFXOT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 18:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263080AbVAFXON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 18:14:13 -0500
Received: from mailer2-5.key-systems.net ([81.3.43.243]:54983 "HELO
	mailer2-1.key-systems.net") by vger.kernel.org with SMTP
	id S263060AbVAFXK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 18:10:26 -0500
Message-ID: <41DDC55B.2030106@mathematica.scientia.net>
Date: Fri, 07 Jan 2005 00:10:19 +0100
From: Christoph Anton Mitterer <cam@mathematica.scientia.net>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrey Melnikoff <temnota+news@kmv.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: Questions about the CMD640 and RZ1000 bugfix support options
References: <41D5D206.1040107@mathematica.scientia.net> <1104676209.15004.58.camel@localhost.localdomain> <e0qta2-7jr.ln1@kenga.kmv.ru> <1105025417.17176.222.camel@localhost.localdomain> <hcr0b2-ofr.ln1@kenga.kmv.ru>
In-Reply-To: <hcr0b2-ofr.ln1@kenga.kmv.ru>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Melnikoff wrote:
 > Alan Cox wrote:
 > >They should be enabled by default.
 >
 > Why? This is really _OLD_ and _BUGGY_ chips. As I see in google - it used
 > in Asustek Pentium MB PCI/I-P54SP4 and some Intel mb for Pentium with
 > Neptune chipsets. All of this MB - for classic Pentium 75/90/100MHz.

What about the following idea?
Both stay enabled by default but the help text explains exactly (as
far as possible) which systems are affected.
This would help newbies like me to decide if those bugfixes are
necessary or not.

Greetings,
cam.
