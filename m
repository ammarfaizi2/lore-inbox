Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265920AbSKFSKJ>; Wed, 6 Nov 2002 13:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265921AbSKFSKI>; Wed, 6 Nov 2002 13:10:08 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:34181 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S265920AbSKFSKH>;
	Wed, 6 Nov 2002 13:10:07 -0500
Date: Wed, 6 Nov 2002 19:16:45 +0100
From: bert hubert <ahu@ds9a.nl>
To: Robinson Maureira Castillo <rmaureira@alumno.inacap.cl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: I'm still getting oops when loading eth modules (e100, eepro100 and tulip)
Message-ID: <20021106181645.GA4600@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Robinson Maureira Castillo <rmaureira@alumno.inacap.cl>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0211061456570.12033-100000@alumno.inacap.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211061456570.12033-100000@alumno.inacap.cl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 02:59:02PM -0300, Robinson Maureira Castillo wrote:
> Hi all,
> I'm still getting this oops, I've setup a page with all information, it's 
> located at <http://alumno.inacap.cl/~rmaureira/kernel/oops/>

Are you very very sure that you are using the same compiler to compile the
kernel and the modules? With the same settings? It is not guaranteed to work
otherwise.

Did you compile the kernel and the modules yourself?

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
