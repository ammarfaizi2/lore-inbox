Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263439AbTJBRkY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 13:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263442AbTJBRkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 13:40:24 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:21978 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263439AbTJBRkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 13:40:18 -0400
Message-ID: <3F7C6319.4010407@onlinehome.de>
Date: Thu, 02 Oct 2003 19:40:41 +0200
From: Hans-Georg Thien <1682-600@onlinehome.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: getting timestamp of last interrupt?
References: <3EB19625.6040904@onlinehome.de>	<3EBAAC12.F4EA298D@hp.com>	<3ED3CECA.9020706@onlinehome.de> <20030527231026.6deff7ed.subscript@free.fr>
In-Reply-To: <20030527231026.6deff7ed.subscript@free.fr>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am looking for a possibility to read out the last timestamp when an 
interrupt has occured.

e.g.: the user presses a key on the keyboard. Where can I read out the 
timestamp of this event?

To be more precise, I 'm looking for

( )a function call
( ) a callback where I can register to be notified when an event occurs
( ) a global accessible variable
( ) a /proc entry

or something like that.

Any ideas ?

- Hans


