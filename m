Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268216AbTBNGLU>; Fri, 14 Feb 2003 01:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268217AbTBNGLU>; Fri, 14 Feb 2003 01:11:20 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:63503 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S268216AbTBNGLT>; Fri, 14 Feb 2003 01:11:19 -0500
Date: Fri, 14 Feb 2003 06:21:10 +0000
From: Christoph Hellwig <hch@infradead.org>
To: workshop@cpt.sahara.co.za
Cc: KML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: Problems with 2.5.*'s SCSI headers and cdrtools
Message-ID: <20030214062109.A18761@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	workshop@cpt.sahara.co.za, KML <linux-kernel@vger.kernel.org>
References: <1045201685.5971.78.camel@workshop.saharact.lan> <20030214055822.A18415@infradead.org> <1045202851.5971.83.camel@workshop.saharact.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1045202851.5971.83.camel@workshop.saharact.lan>; from azarah@gentoo.org on Fri, Feb 14, 2003 at 08:07:31AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 08:07:31AM +0200, Martin Schlemmer wrote:
> > The problem is in cdrtools.  It should not include kernel headers.
> > 
> 
> Ok, so what should it include ?

Glibc's <scsi/scsi.h>

