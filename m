Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbTLDFiR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 00:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbTLDFiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 00:38:17 -0500
Received: from mail.netzentry.com ([157.22.10.66]:20743 "EHLO netzentry.com")
	by vger.kernel.org with ESMTP id S262110AbTLDFiO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 00:38:14 -0500
Message-ID: <3FCEC82F.9080309@netzentry.com>
Date: Wed, 03 Dec 2003 21:37:51 -0800
From: "b@netzentry.com" <b@netzentry.com>
Reply-To: b@netzentry.com
Organization: b@netzentry.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: AMartin@nvidia.com
CC: linux-kernel@vger.kernel.org
Subject: RE: NForce2 pseudoscience stability testing (2.6.0-test11)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allen Martin wrote:
 >Also are people who are having problems using rounded or flat
 >cables?  It's
 >possible the problem could be related to DMA CRC errors.
 >Switching to flat
 >cables can help with that.
 >
 >-Allen

I'm using the one that came with the board, flat 80 wire. It
works under extreme stress in Windows 2000. It doesnt work
in Linux.


(I generated millions of interrupts from IDE and network
(dual gigabit) in Windows 2000 on this very hardware for
3 days - thats why I came to the LKML, I did an empirical
test that indicated Linux, and did some reading and others
have had similar problems.)





