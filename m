Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262171AbREQCJS>; Wed, 16 May 2001 22:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262172AbREQCJI>; Wed, 16 May 2001 22:09:08 -0400
Received: from www.stolica.ru ([62.118.250.25]:18836 "HELO stolica.ru")
	by vger.kernel.org with SMTP id <S262171AbREQCIx>;
	Wed, 16 May 2001 22:08:53 -0400
Date: Thu, 17 May 2001 06:05:52 +0400
From: Dmitry Volkoff <vdb@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: cmpci sound chip lockup
Message-ID: <20010517060552.A3731@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is known issue. cmpci driver included in the kernel is way too old.
I'm using newer driver (revision 4.14) and it works just fine. It was 
announced on lkml long time ago. Last time I checked there was even newer
driver - 5.64. The one in the kernel has version 2.41. Is it possible to 
include the new driver? 

This is the homepage: http://members.home.net/puresoft/cmedia.html

-- 

    DV
