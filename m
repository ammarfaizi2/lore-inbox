Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267128AbSK2TF7>; Fri, 29 Nov 2002 14:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267131AbSK2TF7>; Fri, 29 Nov 2002 14:05:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1294 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267128AbSK2TF7>;
	Fri, 29 Nov 2002 14:05:59 -0500
Message-ID: <3DE7BC18.8060209@pobox.com>
Date: Fri, 29 Nov 2002 14:12:24 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 8139/mii module problem with 2.5.49/50
References: <3DE7324F.B5965432@folkwang-hochschule.de>
In-Reply-To: <3DE7324F.B5965432@folkwang-hochschule.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's a module loader bug...  for now just build 8139too into your kernel 
(CONFIG_8139TOO=y).

