Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbUKGHPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbUKGHPH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 02:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbUKGHPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 02:15:07 -0500
Received: from adsl-64-217-116-74.dsl.hstntx.swbell.net ([64.217.116.74]:55309
	"EHLO dsl-64-217-116-74.dsl.hstntx.swbell.net") by vger.kernel.org
	with ESMTP id S261551AbUKGHPB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 02:15:01 -0500
Message-ID: <418DCB74.6070803@adsl-64-217-116-74.dsl.hstntx.swbell.net>
Date: Sun, 07 Nov 2004 07:15:00 +0000
From: James Tabor <jimtabor@adsl-64-217-116-74.dsl.hstntx.swbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]tar filesystem for 2.6.10-rc1-mm3(easily access tar file)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andyliu wrote:
> hi
> 
>   let's think about the way we access the file which contained in a tar file
> may we can untar the whole thing and we find the file we want to access
> or we can use the t option with tar to list all the files in the tar
> and then untar the only one file we want to access.
> 
>   but with the help of the tarfs,we can mount a tar file to some dir and access
> it easily and quickly.it's like the tarfs in mc.
> 
>  just mount -t tarfs tarfile.tar /dir/to/mnt -o loop
> then access the files easily.
> 
> it was writen by Kazuto Miyoshi (kaz@earth.email.ne.jp) Hirokazu
> Takahashi (h-takaha@mub.biglobe.ne.jp) for linux 2.4.0
> 
> and i make it work for linux 2.6.0. now a patch for linux 2.6.10-rc1-mm3
> 
> the patch is to big to send it as plain text, so i can only send it as
> an attachment
> 
> thanks
> 
Wow! How cool is this! Can you copy files into a tarfs subsystem? Just like
we do with iso's?
Cool,
James

