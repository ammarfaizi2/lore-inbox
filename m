Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUDSQHy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 12:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbUDSQHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 12:07:54 -0400
Received: from smtp.ncy.finance-net.fr ([62.161.220.65]:27148 "EHLO
	smtp.ncy.finance-net.fr") by vger.kernel.org with ESMTP
	id S261179AbUDSQHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 12:07:53 -0400
Date: Mon, 19 Apr 2004 18:07:33 +0200
From: Fabian Fenaut <fabian.fenaut@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20040312 Debian/1.4.1-0jds1
X-Accept-Language: fr
MIME-Version: 1.0
To: Fabian Fenaut <fabian.fenaut@free.fr>
CC: Jean Delvare <khali@linux-fr.org>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Sensors (W83627HF) in Tyan S2882
References: <1082387882.4083edaa52780@imp.gcu.info> <S261321AbUDSQA3/20040419160029Z+1531@vger.kernel.org>
In-Reply-To: <S261321AbUDSQA3/20040419160029Z+1531@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Message-Id: <S261179AbUDSQHx/20040419160753Z+1539@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabian Fenaut a écrit le 19.04.2004 17:59:
> Jean Delvare a écrit le 19.04.2004 17:18:
> 
>> Nice catching. However the fix is not correct. "W83627HF" is the correct
>> name and "W83682HF" is the typo.
> 
> You sure ? Looks like W83627HF is handled by the 2nd one, no ?

... namely SENSORS_W83627HF

