Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbTJAPZU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 11:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbTJAPYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 11:24:40 -0400
Received: from smtp14.eresmas.com ([62.81.235.114]:18597 "EHLO
	smtp14.eresmas.com") by vger.kernel.org with ESMTP id S262362AbTJAPYG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 11:24:06 -0400
Message-ID: <3F7AF183.5050900@wanadoo.es>
Date: Wed, 01 Oct 2003 17:23:47 +0200
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: syn uw <syn_uw@hotmail.com>, linux-kernel@vger.kernel.org,
       marcelo.tosatti@cyclades.com.br, atulm@lsil.com,
       linux-megaraid-devel@dell.com
Subject: Re: Megaraid does not work with 2.4.22
References: <Pine.LNX.4.44.0310011017440.3343-100000@dmt.cyclades>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

> Having two drivers for the same controller is not a good thing from a user

this doesn't is first time:
e100/eepro100 aic7xxx/aic7xxx_old  sym53c8xx_2/sym53c8xx+ncr53c8xx ...

> point of view. I just asked Atul privately but will do so again here: Why
> do we need "megaraid2" ?

megaraid 1.xx gets *very bad* performance. But like 2.4 is stable serie, it
shouldn't be deleted.

megaraid 2.xx gets correct performance, it's stable and it adds support
for _present_ hardware, MegaRAID Ultra320 RAID boards(518, 520, 531, 532).


-thanks-
-- 
:x


