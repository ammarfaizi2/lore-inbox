Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272511AbRH3Vvh>; Thu, 30 Aug 2001 17:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272510AbRH3VvW>; Thu, 30 Aug 2001 17:51:22 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:55027
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S272498AbRH3Vul>; Thu, 30 Aug 2001 17:50:41 -0400
Date: Thu, 30 Aug 2001 14:50:19 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-users@cisco.com, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org
Subject: Re: Linux Mounting problem
Message-ID: <20010830145019.A1451@mikef-linux.matchmail.com>
Mail-Followup-To: linux-users@cisco.com, linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
In-Reply-To: <3B8E5791.5BBE92A2@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B8E5791.5BBE92A2@cisco.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2001 at 08:41:13PM +0530, Venkatesh Ramachandran wrote:
>    The following error messages : ERROR : Couldn't open /dev/null
> (Read-only file system)
> 

Sounds like devfs is compiled in, but not mounted.  Can you verify? 
