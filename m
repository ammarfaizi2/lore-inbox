Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287200AbSBCN70>; Sun, 3 Feb 2002 08:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287208AbSBCN7R>; Sun, 3 Feb 2002 08:59:17 -0500
Received: from smtp-out-1.wanadoo.fr ([193.252.19.188]:59271 "EHLO
	mel-rto1.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S287200AbSBCN7E>; Sun, 3 Feb 2002 08:59:04 -0500
Message-ID: <3C5D41AB.2080207@wanadoo.fr>
Date: Sun, 03 Feb 2002 14:56:59 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020126
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Francois-Xavier 'FiX' KOWALSKI" 
	<francois-xavier.kowalski@club-internet.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.4.17 kills processes in shrink_cache
In-Reply-To: <lvelk23edc.fsf@fuerteventura.fxk.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois-Xavier 'FiX' KOWALSKI wrote:
> I encounter the following kernel error using stock kernel.org 2.4.17:
> kernel BUG at vmscan.c:360!
..snip..
> Looking on various linux-kernel ML archives, I found that the VM is
> having some troubles, but no failure with the same backtrace as the
> one I have, whereas I always have exactly the same one, at least on
> the 2 lowest levels:

Many problems were reported with 2.4.17: kswapd/swapper, ext2 
corruption, devfs bug... Couldn't you upgrade to 2.4.18-pre7 ?


Pierre
-- 
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

