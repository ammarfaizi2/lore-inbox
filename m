Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273204AbRJBMzM>; Tue, 2 Oct 2001 08:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273619AbRJBMzC>; Tue, 2 Oct 2001 08:55:02 -0400
Received: from mailf.telia.com ([194.22.194.25]:16859 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S273204AbRJBMyx>;
	Tue, 2 Oct 2001 08:54:53 -0400
Date: Tue, 2 Oct 2001 14:55:20 +0200
From: =?iso-8859-1?Q?Andr=E9?= Dahlqvist <andre.dahlqvist@telia.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.11-pre2
Message-ID: <20011002145520.A2096@telia.com>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0110011438230.990-100000@penguin.transmeta.com> <200110012218.f91MIGU10233@hswn.dk> <20011002125040.A10878@whirlnet.co.uk> <20011002143939.34e5cd62.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011002143939.34e5cd62.skraw@ithnet.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski <skraw@ithnet.com> wrote:

> > -	action_msg:	"Emergency Remount R/0\n",
> > +	action_msg:	"Emergency Remount R/O\n",
> 
> What exactly do you want to fix with this patch?

If you look closely you'll see that he changed '0' to 'O'.
-- 

André Dahlqvist <andre.dahlqvist@telia.com>
