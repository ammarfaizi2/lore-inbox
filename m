Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWHAGeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWHAGeJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 02:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWHAGeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 02:34:09 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:45248 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932065AbWHAGeG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 02:34:06 -0400
Date: Tue, 1 Aug 2006 08:22:04 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Matthias Andree <matthias.andree@gmx.de>
cc: Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, ipso@snappymail.ca,
       reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
       tytso@mit.edu, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
In-Reply-To: <20060731144736.GA1389@merlin.emma.line.org>
Message-ID: <Pine.LNX.4.61.0608010821300.10130@yvahk01.tjqt.qr>
References: <1153760245.5735.47.camel@ipso.snappymail.ca>
 <200607241806.k6OI6uWY006324@laptop13.inf.utfsm.cl>
 <20060731125846.aafa9c7c.reiser4@blinkenlights.ch> <20060731144736.GA1389@merlin.emma.line.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>> A filesystem with a fixed number of inodes (= not readjustable while
>> mounted) is ehr.. somewhat unuseable for a lot of people with
>> big and *flexible* storage needs (Talking about NetApp/EMC owners)
>
>Which is untrue at least for Solaris, which allows resizing a life file
>system. FreeBSD and


>Linux require an unmount.

Only for shrinking.


Jan Engelhardt
-- 
