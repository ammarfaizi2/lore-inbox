Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbTAVQvf>; Wed, 22 Jan 2003 11:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261894AbTAVQvf>; Wed, 22 Jan 2003 11:51:35 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:64477 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261874AbTAVQve>; Wed, 22 Jan 2003 11:51:34 -0500
Date: Wed, 22 Jan 2003 09:07:39 -0800
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: Hui_Ning@3com.com, linux-kernel@vger.kernel.org
cc: hannal@us.ibm.com
Subject: Re: kernel profiling
Message-ID: <8960000.1043255259@w-hlinder>
In-Reply-To: <OF36859B84.3678DE43-ON86256CB6.00029EEA@3com.com>
References: <OF36859B84.3678DE43-ON86256CB6.00029EEA@3com.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Tuesday, January 21, 2003 06:34:34 PM -0600 Hui_Ning@3com.com wrote:
> 
> hi,
> 
> I am trying to do kernel profile using kernprof with the patch provided by
> SGI on 2.4.18. I can't find the 2.95.3 gcc patch that must be used to
> compile the kernel( the info on sgi's web site somehow is broken).  Does
> anybody know where the patch is ? or any alternative I can use, like
> a more stable gcc version without the need for a patch?

Hello,

	I found that the default red hat 7.3 compiler (gcc-2.96-110)
did not need the patch and ran kernprof fine. 

Hanna

