Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275798AbRJJOBi>; Wed, 10 Oct 2001 10:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275813AbRJJOB2>; Wed, 10 Oct 2001 10:01:28 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:61713 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S275806AbRJJOBX>;
	Wed, 10 Oct 2001 10:01:23 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Tainted Modules Help Notices 
In-Reply-To: Your message of "Wed, 10 Oct 2001 09:59:01 -0400."
             <Pine.GSO.4.21.0110100956420.17790-100000@weyl.math.psu.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 11 Oct 2001 00:01:42 +1000
Message-ID: <13611.1002722502@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2001 09:59:01 -0400 (EDT), 
Alexander Viro <viro@math.psu.edu> wrote:
>On Wed, 10 Oct 2001, Keith Owens wrote:
>> Any license not listed in include/linux/module.h is not GPL compatible.
>> That list is currently (2.4.11)
>> 
>> "GPL"                           [GNU Public License v2 or later]
>> "GPL and additional rights"     [GNU Public License v2 rights and more]
>> "Dual BSD/GPL"                  [GNU Public License v2 or BSD license choice]
>> "Dual MPL/GPL"                  [GNU Public License v2 or Mozilla license choice]
>
>What the hell?  BSD without advertisement clause had always been
>GPL-compatible.

Take it up with AC, modutils is just following his list in module.h.

