Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292805AbSB1AW2>; Wed, 27 Feb 2002 19:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293047AbSB1AVk>; Wed, 27 Feb 2002 19:21:40 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:59040 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S293097AbSB1AUj>; Wed, 27 Feb 2002 19:20:39 -0500
Date: Wed, 27 Feb 2002 16:20:33 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5: (better) syscalls for setting task affinity
Message-ID: <20020227162033.A31585@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <1014853522.1109.234.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1014853522.1109.234.camel@phantasy>; from rml@tech9.net on Wed, Feb 27, 2002 at 06:45:21PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 06:45:21PM -0500, Robert Love wrote:
> [ This post adds length and pointer checks to the syscalls such that we
> can portably change the size of cpus_allowed. ]

Great!  That is what I was going to suggest to your first patch.

-- 
Mike
