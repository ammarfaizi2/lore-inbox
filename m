Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263933AbRF1TI0>; Thu, 28 Jun 2001 15:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263948AbRF1TIQ>; Thu, 28 Jun 2001 15:08:16 -0400
Received: from spiral.extreme.ro ([212.93.159.205]:128 "HELO spiral.extreme.ro")
	by vger.kernel.org with SMTP id <S263933AbRF1TIB>;
	Thu, 28 Jun 2001 15:08:01 -0400
Date: Thu, 28 Jun 2001 22:09:46 +0300 (EEST)
From: Dan Podeanu <pdan@spiral.extreme.ro>
To: Miquel van Smoorenburg <miquels@cistron-office.nl>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Cosmetic JFFS patch.
In-Reply-To: <9hfter$9e7$1@ncc1701.cistron.net>
Message-ID: <Pine.LNX.4.33L2.0106282206510.1123-100000@spiral.extreme.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, my two cents.

Print all copyright, config, etc. as KERN_DEBUG. Then use a 'verbose' or
similar parameter to lilo/kernel to enable console printing of KERN_DEBUG,
to be used when the system fails to boot, etc.

Dan.


