Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264492AbUEMUGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264492AbUEMUGX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 16:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264820AbUEMTxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:53:12 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:21986 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S265113AbUEMTvg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:51:36 -0400
Message-ID: <40A3CF97.5000405@free.fr>
Date: Thu, 13 May 2004 21:42:15 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040501
X-Accept-Language: en
MIME-Version: 1.0
To: eric.valette@free.fr
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-mm2 : Hitting Num Lock kills keyboard
References: <40A3C951.9000501@free.fr>
In-Reply-To: <40A3C951.9000501@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Valette wrote:
> Andrew,
> 
> I tested 2.6.6-mm2 this afternoon and twice I totally lost my keyboard. 

Well, I can reproduce it at will : I just need to hit the numlock key 
and keyboard is frozen.

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr
