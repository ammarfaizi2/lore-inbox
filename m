Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262456AbSJJVFH>; Thu, 10 Oct 2002 17:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262525AbSJJVFH>; Thu, 10 Oct 2002 17:05:07 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:42735 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262456AbSJJVFG>; Thu, 10 Oct 2002 17:05:06 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <OFFB04937F.1EAC8996-ON87256C4E.006DA4CF@boulder.ibm.com> 
References: <OFFB04937F.1EAC8996-ON87256C4E.006DA4CF@boulder.ibm.com> 
To: "Steven French" <sfrench@us.ibm.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, jra@samba.org
Subject: Re: [BK PATCH] CIFS filesystem for Linux 2.5 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 10 Oct 2002 22:10:32 +0100
Message-ID: <17092.1034284232@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sfrench@us.ibm.com said:
>  fs/cifs/md4.c                      |  209 +++
>  fs/cifs/md5.c                      |  363 +++++
>  fs/cifs/md5.h                      |   38 

Unless these are somehow CIFS-specific, they should live in linux/lib/

--
dwmw2


