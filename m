Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263056AbSJBLDL>; Wed, 2 Oct 2002 07:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263057AbSJBLDK>; Wed, 2 Oct 2002 07:03:10 -0400
Received: from tml.hut.fi ([130.233.44.1]:22033 "EHLO tml-gw.tml.hut.fi")
	by vger.kernel.org with ESMTP id <S263056AbSJBLDJ>;
	Wed, 2 Oct 2002 07:03:09 -0400
Date: Wed, 2 Oct 2002 14:08:28 +0300
From: Antti Tuominen <ajtuomin@morphine.tml.hut.fi>
To: "YOSHIFUJI Hideaki / =?ISO-8859-1?Q?=1B$B5HF#1QL@=1B(B=22?= <yoshfuji@wide.ad.jp>"@vax.home.local
Cc: davem@redhat.com, kuznet@ms2.inr.ac.ru, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] Mobile IPv6 for 2.5.40 (request for kernel inclusion)
Message-ID: <20021002110828.GD17010@morphine.tml.hut.fi>
References: <20021002092111.GB17010@morphine.tml.hut.fi> <20021002.184607.73791540.yoshfuji@wide.ad.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021002.184607.73791540.yoshfuji@wide.ad.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 06:46:07PM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B wrote:
> Resolving www.mipl.mediapoli.com... done.
> Connecting to www.mipl.mediapoli.com[212.68.2.195]:80... connected.
> HTTP request sent, awaiting response... 403 Forbidden
> 18:45:25 ERROR 403: Forbidden.

Sorry about that.  Apache had some strange rule denying download of
files with .diff suffix.  Now works.  Add .gz to the url for gzipped
version.

Regards,

Antti

-- 
Antti J. Tuominen, Gyldenintie 8A 11, 00200 Helsinki, Finland.
Research assistant, Institute of Digital Communications at HUT
work: ajtuomin@tml.hut.fi; home: tuominen@iki.fi

