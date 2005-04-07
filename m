Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262505AbVDGQLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262505AbVDGQLx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 12:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbVDGQLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 12:11:53 -0400
Received: from r3az252.chello.upc.cz ([213.220.243.252]:11169 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S262505AbVDGQLv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 12:11:51 -0400
Message-ID: <42555BC5.8050307@ribosome.natur.cuni.cz>
Date: Thu, 07 Apr 2005 18:11:49 +0200
From: =?ISO-8859-1?Q?Martin_MOKREJS=28?= 
	<mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8b2) Gecko/20050407
MIME-Version: 1.0
To: Martin MOKREJ? <mmokrejs@ribosome.natur.cuni.cz>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: find: /usr/src/linux-2.4.30/include/asm: Too many levels of symbolic
 links
References: <4255252D.4050708@ribosome.natur.cuni.cz> <20050407123407.GF12342@DervishD>
In-Reply-To: <20050407123407.GF12342@DervishD>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD wrote:

>> again I've hit some wird problem doing "make dep" for 2.4 kernel:
> 
> 
>     Not a kernel problem but a findutils problem. Fixed in 4.2.19,
> but 4.2.20 was released recently. Upgrade.

You were right. Thanks!
M.
