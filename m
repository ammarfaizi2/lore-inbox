Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUBHF7D (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 00:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbUBHF7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 00:59:03 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:28079 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262328AbUBHF7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 00:59:02 -0500
Message-ID: <4025D01B.9090205@t-online.de>
Date: Sun, 08 Feb 2004 06:58:51 +0100
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040129
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Murilo Pontes <murilo_pontes@yahoo.com.br>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.6.2 crazy mouse under heavy load
References: <200402051417.21428.murilo_pontes@yahoo.com.br>
In-Reply-To: <200402051417.21428.murilo_pontes@yahoo.com.br>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: ZqijByZrge8hSQ3+R6jO8Sb67l2RZAkz-Gan9tFtreMNdd7LFUj2ZD
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Murilo Pontes wrote:
> Compiling recent kde-3.2.0-final, on twm with xterm, several times the mouse is out of control!!!!
> 

Tried to disable CONFIG_PREEMPT? I kicked it out,
and my mouse never went mad since then. Surely
just a workaround (if it helps at all).


Good luck

Harri
