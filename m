Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbVLYVKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbVLYVKk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 16:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbVLYVKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 16:10:40 -0500
Received: from webmail.univie.ac.at ([131.130.1.47]:43732 "EHLO
	webmail1.univie.ac.at") by vger.kernel.org with ESMTP
	id S1750929AbVLYVKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 16:10:39 -0500
Message-ID: <1379.81.217.14.229.1135545026.squirrel@webmail.univie.ac.at>
In-Reply-To: <20051225210118.GB1498@vanheusden.com>
References: <200512221352.23393.axel.kernel@kittenberger.net>
    <20051222173704.GB23411@buici.com>
    <1167.81.217.14.229.1135275158.squirrel@webmail.univie.ac.at>
    <20051222183012.GA27353@buici.com>
    <20051225210118.GB1498@vanheusden.com>
Date: Sun, 25 Dec 2005 22:10:26 +0100 (CET)
Subject: Re: Possible Bootloader Optimization in inflate (get rid of 
     unnecessary 32k Window)
From: "Axel Kittenberger" <axel.kittenberger@univie.ac.at>
To: "Folkert van Heusden" <folkert@vanheusden.com>
Cc: "Marc Singer" <elf@buici.com>, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On the other hand it makes the kernel a few bytes smaller :-)

Well on rather slow machines it is a bit faster indeed, I did code it 3
years ago for an embedded system (embedded PowerPC). 'til now I just never
found the time to offer a patch back to "vanilla" linux. I recently just
thought I could ask maybe if it is after all desired even so....

Greetings, Axel

