Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269312AbUINLkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269312AbUINLkm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 07:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269313AbUINLiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 07:38:55 -0400
Received: from outmx015.isp.belgacom.be ([195.238.2.87]:33437 "EHLO
	outmx015.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S269314AbUINLhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 07:37:24 -0400
Message-ID: <4146D833.8040703@246tNt.com>
Date: Tue, 14 Sep 2004 13:38:27 +0200
From: Sylvain Munaut <tnt@246tNt.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040816)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux PPC Dev <linuxppc-dev@ozlabs.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/9] Small updates for Freescale MPC52xx
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here is a bunch of small updates / fix for Freescale MPC52xx. Some of 
them are now required for a proper compilation.
They mostly only modify the mpc52xx specific code and not much common code.

Theses are in my tree since some time now and have been tested by 
several peoples.

As usual, a BK tree is available with all of theses changes :

bk://bkbits.246tNt.com/linux-2.5-mpc52xx-pending


Comments / Reports are welcome.


    Sylvain Munaut
