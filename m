Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313909AbSDPVFI>; Tue, 16 Apr 2002 17:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313910AbSDPVFI>; Tue, 16 Apr 2002 17:05:08 -0400
Received: from x-o.clustermonkey.org ([64.242.77.225]:5588 "EHLO
	x-o.clustermonkey.org") by vger.kernel.org with ESMTP
	id <S313909AbSDPVFH>; Tue, 16 Apr 2002 17:05:07 -0400
Date: Tue, 16 Apr 2002 17:05:06 -0400
From: Adam Lazur <adam@lazur.org>
To: Dale Amon <amon@vnl.com>, linux-kernel@vger.kernel.org
Subject: Re: Translucent overmounts
Message-ID: <20020416210506.GH23305@clustermonkey.org>
In-Reply-To: <20020416182644.GA7427@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dale Amon (amon@vnl.com) said:
> It would be useful to take an RO device and overmount (or vice
> versa) a ramdisk for temporary data. Say a /etc on CDROM with
> an overmounted /etc/mtab...
> 
> Is anyone working on such a translucent file system? 

What you're talking about is normally called a union mount.

I think I saw somewhere that Al Viro was working on it.

-- 
Adam Lazur, Cluster Monkey
