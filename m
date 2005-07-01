Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263266AbVGAHpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263266AbVGAHpT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 03:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263269AbVGAHpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 03:45:19 -0400
Received: from mailfe03.tele2.fr ([212.247.154.76]:43137 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S263266AbVGAHpN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 03:45:13 -0400
X-T2-Posting-ID: k1c2aGMK8Lj9Cnpb+Eju4eOhqUzXuhsckJNC9B9P7R8=
Date: Fri, 1 Jul 2005 09:46:41 +0200
From: Frederik Deweerdt <frederik.deweerdt@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org, frankvm@frankvm.com
Subject: Re: FUSE merging?
Message-ID: <20050701074641.GD8679@gilgamesh.home.res>
Mail-Followup-To: Miklos Szeredi <miklos@szeredi.hu>, akpm@osdl.org,
	aia21@cam.ac.uk, arjan@infradead.org, linux-kernel@vger.kernel.org,
	frankvm@frankvm.com
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu> <20050630022752.079155ef.akpm@osdl.org> <E1Dnvhv-0000SK-00@dorka.pomaz.szeredi.hu> <1120125606.3181.32.camel@laptopd505.fenrus.org> <E1Dnw2J-0000UM-00@dorka.pomaz.szeredi.hu> <1120126804.3181.34.camel@laptopd505.fenrus.org> <1120129996.5434.1.camel@imp.csi.cam.ac.uk> <20050630124622.7c041c0b.akpm@osdl.org> <E1DoF86-0002Kk-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <E1DoF86-0002Kk-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.6i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 01/07/05 08:36 +0200, Miklos Szeredi écrivit:
> Here's a description of a theoretical DoS scenario:
> 
>   http://marc.theaimsgroup.com/?l=linux-fsdevel&m=111522019516694&w=2
> 
> Miklos
Could this be solved by implementing some sort of (optional) timeout on fuse
syscalls (in request_send)?

Fred

-- 
o---------------------------------------------o
| http://open-news.net : l'info alternative   |
| Tech - Sciences - Politique - International |
o---------------------------------------------o
