Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132450AbRCZObk>; Mon, 26 Mar 2001 09:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132454AbRCZOba>; Mon, 26 Mar 2001 09:31:30 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:59370 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132450AbRCZObU>;
	Mon, 26 Mar 2001 09:31:20 -0500
Message-ID: <3ABF528F.F2C39BA0@mandrakesoft.com>
Date: Mon, 26 Mar 2001 09:30:39 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Hen, Shmulik" <shmulik.hen@intel.com>
Cc: "'LKML'" <linux-kernel@vger.kernel.org>
Subject: Re: Q: How do I get from the latest stable kernel version to the latest 
 prepatch version ?
In-Reply-To: <07E6E3B8C072D211AC4100A0C9C5758302B27192@hasmsx52.iil.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Hen, Shmulik" wrote:
> 
> Hi,
> 
> According to http://www.kernel.org, the latest stable kernel version is
> 2.4.2. The latest prepatch version is 2.4.3-pre3.
> 
> In order to get a full 2.4.3-pre8 kernel do I have to:
> 
> A. download linux-2.4.2.tar.gz and all the patch-2.4.3-preX.gz and apply
> them in succession or,
> B. download linux-2.4.3.tar.gz (exists ?) and then apply the all patches or,
> C. download linux-2.4.3-pre7.tar.gz (exists ?) and apply only
> patch-2.4.3-pre8.gz ?

Apply only the latest patch, currently 2.4.3-pre8.

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full moon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
