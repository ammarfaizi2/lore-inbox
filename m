Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273333AbRIRKaA>; Tue, 18 Sep 2001 06:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273331AbRIRK3y>; Tue, 18 Sep 2001 06:29:54 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:36848 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S273330AbRIRK33>; Tue, 18 Sep 2001 06:29:29 -0400
Date: Tue, 18 Sep 2001 11:29:30 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: =?iso-8859-1?Q?Christian_Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
Cc: Juan <piernas@ditec.um.es>, linux-kernel@vger.kernel.org,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: Ext3 journal on its own device?
Message-ID: <20010918112930.C12248@redhat.com>
In-Reply-To: <3BA61CC0.C9ECC8A0@ditec.um.es> <E15j19N-0006Gh-00@mrvdom03.schlund.de> <3BA62575.E14C5808@ditec.um.es> <E15j1RG-00082a-00@mrvdom03.schlund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15j1RG-00082a-00@mrvdom03.schlund.de>; from linux-kernel@borntraeger.net on Mon, Sep 17, 2001 at 06:39:10PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 17, 2001 at 06:39:10PM +0200, Christian Bornträger wrote:
> > But the problem is that I need to use Linux 2.2.19, and the latest Ext3
> > version for that kernel is 0.0.7a, isn't it?.
> 
> good point. I am not sure if ext3 is still maintained for linux 2.2, but I 
> doubt it. Andrew or Stephen should be able to answer this question.

Critical bugfixes only for 2.2.  All current development is 2.4 only.
There are _tons_ of improvements in 2.4 which will not be back-ported;
2.4 is the official current ext3.

Cheers,
 Stephen
