Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289631AbSBYQxN>; Mon, 25 Feb 2002 11:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293429AbSBYQxD>; Mon, 25 Feb 2002 11:53:03 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:28033 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S289631AbSBYQxA>; Mon, 25 Feb 2002 11:53:00 -0500
Date: Mon, 25 Feb 2002 09:52:44 -0700
Message-Id: <200202251652.g1PGqis04726@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Mauricio Pretto <pretto@interage.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rc.devfs
In-Reply-To: <3C7A693E.17FEE86@interage.com.br>
In-Reply-To: <3C7A693E.17FEE86@interage.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauricio Pretto writes:
> In the 2.4.17 tree i cant find the rc.devfs script
> have been discontinued?

That's right. It's long obsolete, so I removed it. Everyone should be
using devfsd now for permissions persistence.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
