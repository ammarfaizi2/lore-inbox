Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262885AbSJWGiG>; Wed, 23 Oct 2002 02:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262887AbSJWGiG>; Wed, 23 Oct 2002 02:38:06 -0400
Received: from franka.aracnet.com ([216.99.193.44]:63954 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262885AbSJWGiF>; Wed, 23 Oct 2002 02:38:05 -0400
Date: Tue, 22 Oct 2002 23:42:11 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: New panic (io-apic / timer?) going from 2.5.44 to 2.5.44-mm1
Message-ID: <2718638835.1035330130@[10.10.2.3]>
In-Reply-To: <2715941567.1035327433@[10.10.2.3]>
References: <2715941567.1035327433@[10.10.2.3]>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The kgdb code plays around at that level too.  A patch -R of
>> kgdb.patch would be interesting.
> 
> OK ... will try that then brute force and ignorance (binary chop
> search) I guess.

Your psychic powers seem to be on form. Was kgdb. Worked in
41-mm1 for me on the same machine though.

M.

