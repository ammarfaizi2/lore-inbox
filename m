Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281519AbRKHL3o>; Thu, 8 Nov 2001 06:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281522AbRKHL3e>; Thu, 8 Nov 2001 06:29:34 -0500
Received: from t2.redhat.com ([199.183.24.243]:51448 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S281516AbRKHL3T>; Thu, 8 Nov 2001 06:29:19 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.21.0111081237330.24010-100000@localhost.localdomain> 
In-Reply-To: <Pine.LNX.4.21.0111081237330.24010-100000@localhost.localdomain> 
To: Manik Raina <manik@cisco.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix for redefinition of jedec_probe_init 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 08 Nov 2001 11:29:05 +0000
Message-ID: <2649.1005218945@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


manik@cisco.com said:
>  I am sending a patch which makes them static. Of course, there is
> another option, since both these functions are doing the same thing,
> we could delete one of them. 

A third option is to read the list archives before posting and read 
what the maintainer said last time this was pointed out, only a few days 
ago.


--
dwmw2


