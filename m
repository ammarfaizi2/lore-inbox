Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030576AbWJ3TdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030576AbWJ3TdF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 14:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030559AbWJ3TdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 14:33:04 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:35044 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1030467AbWJ3TdB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 14:33:01 -0500
Message-ID: <45465359.4060500@gmail.com>
Date: Mon, 30 Oct 2006 20:32:41 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: dragoran <dragoran@feuerpokemon.de>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: ipw3945?
References: <45464A55.20803@feuerpokemon.de> <1162234779.2948.67.camel@laptopd505.fenrus.org>
In-Reply-To: <1162234779.2948.67.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: jirislaby@gmail.com
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Mon, 2006-10-30 at 19:54 +0100, dragoran wrote:
>> The ipw3945 driver has been out for a while and is not yet upstream.
>> It requires a binary only daemon to work, but I still see no reason not
>> to merge it.
>> Many wlan drivers require binary firmware anyway, so I don't see a
>> reason not to merge it.
> 
> has Intel submitted it for inclusion?
> 
> No.

It seems to be still in a devel phase -- it doesn't work for me (and other people):
http://bughost.org/bugzilla/show_bug.cgi?id=1152

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
