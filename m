Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbVJFTXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbVJFTXw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 15:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbVJFTXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 15:23:52 -0400
Received: from prosun.first.fraunhofer.de ([194.95.168.2]:25481 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1751323AbVJFTXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 15:23:51 -0400
To: linux-kernel@vger.kernel.org
Date: Thu, 06 Oct 2005 21:23:48 +0200
From: Soeren Sonnenburg <kernel@nn7.de>
Message-ID: <pan.2005.10.06.19.23.47.683250@nn7.de>
Organization: Local Intranet News
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: orinoco vs. waproamd ?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I used to use orinoco-cvs from april 2005 together with waproamd and
kernel 2.6.11/12 without any trouble. However since 2.6.13 and also in
2.6.14-rc{2,3} waproamd first puts up the interface and initializes it
correctly and then somehow gets confused with ssid's and sets only a part
of it, e.g. instead of 'iamanssid': 'anssid'

wich of course kills the connection and then the process seems to go on
and on...

does anyone have an idea whether this is a kernel bug or one in waproamd ?

(this is on a pbook 15" 1GHz btw)

Soeren.


