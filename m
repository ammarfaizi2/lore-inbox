Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbTEAOJK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 10:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbTEAOJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 10:09:10 -0400
Received: from fep01.superonline.com ([212.252.122.40]:22172 "EHLO
	fep01.superonline.com") by vger.kernel.org with ESMTP
	id S261267AbTEAOJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 10:09:09 -0400
Message-ID: <3EB12D42.4010502@superonline.com>
Date: Thu, 01 May 2003 17:20:50 +0300
From: "O.Sezer" <sezero@superonline.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: tmb@iki.fi
Subject: Re: [PATCH 2.4.21-rc1] vesafb with large memory
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-9; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Backlund wrote:

[SNIPPED]
 >
 > So this way we wont break current systems,
 > but have an option for those cards that has problem...
 > (seems to be AGP + >=128MB VideoRAM + >=1024MB system RAM only)

AGP			-> Yes
 >= 128MB RAM		-> Yes
 >=1024MB system RAM	-> _ NO _.  Only 256MB
(OK, I added another 128 today, so it's 384 now :))

Regards;
Özkan Sezer

