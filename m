Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291104AbSBLPPu>; Tue, 12 Feb 2002 10:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291103AbSBLPPo>; Tue, 12 Feb 2002 10:15:44 -0500
Received: from h108-129-61.datawire.net ([207.61.129.108]:39186 "HELO
	mail.datawire.net") by vger.kernel.org with SMTP id <S291104AbSBLPP3>;
	Tue, 12 Feb 2002 10:15:29 -0500
Subject: Re: 2.4.18-pre9-xfs-shawn4  -  kmem_cache_alloc oops
From: Shawn Starr <shawn.starr@datawire.net>
To: Tarkan Erimer <tarkane@solmaz.com.tr>
Cc: Linux <linux-kernel@vger.kernel.org>
In-Reply-To: <01f601c1b3d6$c94ca060$040010ac@LocalHost>
In-Reply-To: <20020212141007.B223@dagb> <1013523257.262.3.camel@unaropia> 
	<01f601c1b3d6$c94ca060$040010ac@LocalHost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99 (Preview Release)
Date: 12 Feb 2002 10:18:14 -0500
Message-Id: <1013527094.263.17.camel@unaropia>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is in the works. I'm trying to iron out any buglets that remain and
make sure that I don't break anything in the process ;-)

Shawn.

On Tue, 2002-02-12 at 10:06, Tarkan Erimer wrote:
> Hi Shawn,
> 
> Do you plan to add XFS support to .mjc patches ? 
> If so, I would be soo grateful. 
> 
> Tarkan
> 
> ----- Original Message ----- 
> From: Shawn Starr <spstarr@sh0n.net>
> To: Dag Bakke <dag@bakke.com>
> Cc: Linux <linux-kernel@vger.kernel.org>; xfs <linux-xfs@oss.sgi.com>
> Sent: Tuesday, February 12, 2002 4:13 PM
> Subject: Re: 2.4.18-pre9-xfs-shawn4 - kmem_cache_alloc oops
> 
> 
> > Interesting, I have CONFIG_PNPBIOS on.
> > What other filesystems do you have or is it just XFS only?
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
-- 
Shawn Starr
Developer Support Engineer
Datawire Communication Networks Inc.
10 Carlson Court, Suite 300
Toronto, ON, M9W 6L2
T: 416-213-2001 ext 179  F: 416-213-2008

