Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293216AbSCAKCe>; Fri, 1 Mar 2002 05:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310441AbSCAKAj>; Fri, 1 Mar 2002 05:00:39 -0500
Received: from ns.suse.de ([213.95.15.193]:26897 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310422AbSCAJ5Y>;
	Fri, 1 Mar 2002 04:57:24 -0500
Date: Fri, 1 Mar 2002 10:56:32 +0100
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul Gortmaker <p_gortmaker@yahoo.com>, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bluesmoke/MCE support optional
Message-ID: <20020301105632.B7662@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Paul Gortmaker <p_gortmaker@yahoo.com>, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C7E465A.4B3F4D9@yahoo.com> <E16gaeU-0001di-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16gaeU-0001di-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Mar 01, 2002 at 12:11:57AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2002 at 12:11:57AM +0000, Alan Cox wrote:
 > Is the MCE code big enough to justify this ? Last time I checked it was
 > 1800 bytes 1000 of which were __init

 And boot-time disable-able. Seems a bit unnecessary to me, but
 if theres enough people wanting it....

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
