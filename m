Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262956AbUJ1KvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262956AbUJ1KvQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 06:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262894AbUJ1KvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 06:51:15 -0400
Received: from mail-gateway-0-1.landonet.net ([196.25.111.196]:33515 "EHLO
	mail-gateway-0-1.landonet.net") by vger.kernel.org with ESMTP
	id S262956AbUJ1KvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 06:51:12 -0400
Message-ID: <4180CF03.3090207@lbsd.net>
Date: Thu, 28 Oct 2004 10:50:43 +0000
From: Nigel Kukard <nkukard@lbsd.net>
Organization: Linux Based Systems Design
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041012
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9bk6 msdos fs OOPS
References: <41809921.10200@lbsd.net>	<200410281055.47263.vda@port.imtp.ilyichevsk.odessa.ua>	<4180A9A4.4000503@lbsd.net> <873bzzw60c.fsf@devron.myhome.or.jp>
In-Reply-To: <873bzzw60c.fsf@devron.myhome.or.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi wrote:

>This is known problem. Can you please try the following patch?
>Then, please send debugging output.
>
>Thanks.
>  
>
using 2.6.9-bk6...

fat_cache_check: tsc 239046359353, comm eog, pid 4293, id 0, contig 0, 
fclus 1, dclus 274
tsc 239046276777, comm eog, pid 4294, id 1, contig 2, fclus 1, dclus 274

Glad I can help... let me know if you need anything else.

Regards
Nigel Kukard

