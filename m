Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268709AbTGJBnp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 21:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268711AbTGJBnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 21:43:45 -0400
Received: from h68-147-156-215.cg.shawcable.net ([68.147.156.215]:39296 "EHLO
	tooleweb.homelinux.com") by vger.kernel.org with ESMTP
	id S268709AbTGJBno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 21:43:44 -0400
Message-ID: <3F0CC833.20607@tooleweb.homelinux.com>
Date: Wed, 09 Jul 2003 19:58:11 -0600
From: Robert Toole <tooler@tooleweb.homelinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: VIA KT400-A AGP 3.0 Support
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am wondering if anyone is currently working on a fix for AGP 3.0 on 
the VIA KT400, KT400-A chipsets, and is looking for someone to test patches.

I am using a Gigabyte GA-7VAX-A board with the KT400-A chipset, and a 
Matrox Marvel eTV Video card (G450). This is a 4X card, but it appears 
to me that VIA removed AGP 2.0 support from the KT400-A.

As far as I can tell, although my videocard is 4X, according to 
Giga-byte, the KT400-A supports only 4X and 8X cards using AGP 3.0 mode 
only.

I have tried the backport from the 2.5 tree that was posted a while ago, 
and while it appeared to work, X crashed hard every time I ran a 3D app.

Thanks in advance,

-- 
Robert Toole
tooler@tooleweb.homelinux.com

