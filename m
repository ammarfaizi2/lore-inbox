Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262258AbSLZEAT>; Wed, 25 Dec 2002 23:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262324AbSLZEAT>; Wed, 25 Dec 2002 23:00:19 -0500
Received: from paiol.terra.com.br ([200.176.3.18]:15514 "EHLO
	paiol.terra.com.br") by vger.kernel.org with ESMTP
	id <S262258AbSLZEAS>; Wed, 25 Dec 2002 23:00:18 -0500
Message-ID: <3E0A63F3.8020705@terra.com.br>
Date: Thu, 26 Dec 2002 02:05:39 +0000
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Josh Brooks <user@mail.econolodgetulsa.com>
Cc: Billy Rose <billyrose@billyrose.net>, bp@dynastytech.com,
       linux-kernel@vger.kernel.org
Subject: Re: CPU failures ... or something else ?
References: <20021225200357.U6873-100000@mail.econolodgetulsa.com>
In-Reply-To: <20021225200357.U6873-100000@mail.econolodgetulsa.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Brooks wrote:
> Understood.  Thank you for that diagnosis.
> 
> usually it says proc #1 in the error, but the first time it said proc #0 -
> is that interesting ?

	It is.

	This would be a stronger evidence of bad RAM, since the instruction 
fetch error occured "randomly" on both processors.

	Either that or both your processors are going bad :)

	Please run memtest86 to be sure it's a bad RAM problem.

	Kind Regards,

Felipe

