Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312601AbSEIN4e>; Thu, 9 May 2002 09:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312920AbSEIN4d>; Thu, 9 May 2002 09:56:33 -0400
Received: from imladris.infradead.org ([194.205.184.45]:24593 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S312601AbSEIN4d>; Thu, 9 May 2002 09:56:33 -0400
Date: Thu, 9 May 2002 14:56:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andries.Brouwer@cwi.nl
Cc: dalecki@evision-ventures.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [PATCH] hdreg.h
Message-ID: <20020509145608.A19587@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andries.Brouwer@cwi.nl, dalecki@evision-ventures.com,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <UTC200205091348.g49DmWe18144.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2002 at 03:48:32PM +0200, Andries.Brouwer@cwi.nl wrote:
> No, fdisk, cfdisk, sfdisk do not use HDIO_GETGEO_BIG.
> And indeed, the ioctl is completely meaningless.

In many current distributions (e.g. from Red Hat, Mandrake and Caldera)
they do.
