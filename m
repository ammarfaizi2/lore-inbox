Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280035AbRLLNpW>; Wed, 12 Dec 2001 08:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280002AbRLLNpN>; Wed, 12 Dec 2001 08:45:13 -0500
Received: from mail.zmailer.org ([194.252.70.162]:17931 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S280056AbRLLNpB>;
	Wed, 12 Dec 2001 08:45:01 -0500
Date: Wed, 12 Dec 2001 15:44:50 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Petr Titera <P.Titera@century.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 4GB file size limit on SMBFS
Message-ID: <20011212154450.H1020@mea-ext.zmailer.org>
In-Reply-To: <3C175A07.6000505@century.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C175A07.6000505@century.cz>; from P.Titera@century.cz on Wed, Dec 12, 2001 at 02:22:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2001 at 02:22:15PM +0100, Petr Titera wrote:
> Hello,
> 
> 	I tested patches from Urban Wildmark to give SMBFS LFS support and
> found, that limit on file size has only moved from 2GB to 4GB.
> Is this expected behaviour?

  It is a possible behaviour.
  There are no public official documents about how M$ has extended the SMB
  protocol in various systems.  Apparently there are discrepancies even
  within M$ about how to do those extensions, thus newer M$ systems have
  more and more tests and work-arounds to handle various extensions.

> Petr Titera
> P.Titera@century.cz

/Matti Aarnio
