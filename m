Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283310AbRK2Qfk>; Thu, 29 Nov 2001 11:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283311AbRK2Qfa>; Thu, 29 Nov 2001 11:35:30 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:29688 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S283310AbRK2QfW>;
	Thu, 29 Nov 2001 11:35:22 -0500
Date: Thu, 29 Nov 2001 09:35:02 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Petr Titera <P.Titera@century.cz>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Windows CP1250 support
Message-ID: <20011129093502.D29249@lynx.no>
Mail-Followup-To: Petr Titera <P.Titera@century.cz>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C065CEC.8090201@century.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3C065CEC.8090201@century.cz>; from P.Titera@century.cz on Thu, Nov 29, 2001 at 05:06:04PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 29, 2001  17:06 +0100, Petr Titera wrote:
> Linux contains two codepages for Central European languages (CP852 and
> iso8859-2) but neither one is correct for character encoding used in 
> Central European version of Windows (which uses Microsoft's CP1250). 
> This patch adds support for this codepage.
> 
> +MODULE_LICENSE("BSD without advertising clause");

Can you please pick a valid license for new files?  ("Dual GPL/BSD" is
probably what you want).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

