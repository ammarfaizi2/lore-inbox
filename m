Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318061AbSFSXsg>; Wed, 19 Jun 2002 19:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318063AbSFSXsf>; Wed, 19 Jun 2002 19:48:35 -0400
Received: from ip68-9-71-221.ri.ri.cox.net ([68.9.71.221]:58235 "EHLO
	mail.blue-labs.org") by vger.kernel.org with ESMTP
	id <S318061AbSFSXsa>; Wed, 19 Jun 2002 19:48:30 -0400
Message-ID: <3D111840.30605@blue-labs.org>
Date: Wed, 19 Jun 2002 19:48:16 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020618
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dax Kelson <dax@gurulabs.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Anyone using NFSv4?
References: <11E89240C407D311958800A0C9ACF7D13A7881@EXCHANGE>	<200206171900.03955.rwhite@pobox.com> 	<008001c216c8$d0bfdba0$294b82ce@connecttech.com> <1024462781.17191.18.camel@thud>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Bmilter: Processing completed, Bmilter version 0.1.0 build 753; timestamp 2002-06-19 19:48:18, message serial number 40352
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My first glance at it suggested that only ext2/ext3 filesystems were 
supported.  I run all reiserfs so I'l have to wait.

David

Dax Kelson wrote:

>I noticed that the CITI group release a new June snapshot of NFSv4
>support for Linux. It is a patch against 2.4.18.
>
>http://www.citi.umich.edu/projects/nfsv4/june_2002_rel/index.html
>
>They say, "The current version passes all Connectathon tests, and
>interoperates with other implementations".
>
>Currently NFSv2/3 is too insecure for my tastes, I'm greatly looking
>forward to the strong authentication, integrity, and privacy that NFSv4
>with secure RPC offers. I can envision handy uses for the "pseudo path"
>feature of NFSv4 as well.
>
>I was just wondering if anyone (other that CITI) is keeping an eye on
>it? Are there any pieces worth merging yet?  Just curious.
>
>Dax Kelson
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

