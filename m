Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290120AbSCCWkN>; Sun, 3 Mar 2002 17:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290184AbSCCWkD>; Sun, 3 Mar 2002 17:40:03 -0500
Received: from ns.suse.de ([213.95.15.193]:48647 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290120AbSCCWjy>;
	Sun, 3 Mar 2002 17:39:54 -0500
Date: Sun, 3 Mar 2002 23:39:52 +0100
From: Dave Jones <davej@suse.de>
To: Diego Calleja <DiegoCG@teleline.es>
Cc: linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: 2.4.19-pre1-aa1 problems
Message-ID: <20020303233952.A11129@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Diego Calleja <DiegoCG@teleline.es>, linux-kernel@vger.kernel.org,
	andrea@suse.de
In-Reply-To: <20020303214135.7fb8f07c.DiegoCG@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020303214135.7fb8f07c.DiegoCG@teleline.es>; from DiegoCG@teleline.es on Sun, Mar 03, 2002 at 09:41:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 03, 2002 at 09:41:35PM +0100, Diego Calleja wrote:
 > 
 > Mar  3 20:39:17 localhost kernel: Unable to handle kernel paging request at virtual address 04740010
 > Mar  3 20:39:17 localhost kernel: c01a078a
 > Mar  3 20:39:17 localhost kernel: *pde = 00000000
 > Mar  3 20:39:17 localhost kernel: Oops: 0000
 > Mar  3 20:39:17 localhost kernel: CPU:    0
 > Mar  3 20:39:17 localhost kernel: EIP:    0010:[sock_poll+30/40]    Tainted: P

 Which modules do you have loaded ?

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
