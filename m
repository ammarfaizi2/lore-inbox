Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263020AbUDECqo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 22:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263034AbUDECqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 22:46:44 -0400
Received: from smtp2.world-net.co.nz ([203.96.119.37]:49673 "HELO
	mail.world-net.co.nz") by vger.kernel.org with SMTP id S263020AbUDECpq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 22:45:46 -0400
Subject: Re: Kernel panic in 2.4.25
From: Matt Brown <matt@mattb.net.nz>
To: Nivedita Singhvi <niv@us.ibm.com>
Cc: marcelo.tosatti@cyclades.com, kernel@linuxace.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       dlstevens@us.ibm.com, davem@redhat.com
In-Reply-To: <4070BE29.9050305@us.ibm.com>
References: <1081129354.1611.44.camel@argon.shr.crc.net.nz>
	 <4070BE29.9050305@us.ibm.com>
Content-Type: text/plain
Message-Id: <1081133145.1611.46.camel@argon.shr.crc.net.nz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 05 Apr 2004 14:45:45 +1200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-04-05 at 14:02, Nivedita Singhvi wrote:
> Could you try applying the following patch:
> 
> http://marc.theaimsgroup.com/?l=linux-netdev&m=108079992001559&w=2

Works perfectly. I will test more extensively over the next day or two. 

This patch will be in 2.4.26 when it is released I assume?

Regards

-- 
Matt Brown
Email: matt@mattb.net.nz
GSM  : 021 611 544

