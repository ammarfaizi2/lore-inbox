Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277386AbRJJT7f>; Wed, 10 Oct 2001 15:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277387AbRJJT70>; Wed, 10 Oct 2001 15:59:26 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:30971
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S277386AbRJJT7P>; Wed, 10 Oct 2001 15:59:15 -0400
Date: Wed, 10 Oct 2001 12:59:39 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "attempt to access beyond end of device" in 2.4.10ac10
Message-ID: <20011010125939.A524@mikef-linux.matchmail.com>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.NEB.4.40.0110101944350.29038-200000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.NEB.4.40.0110101944350.29038-200000@mimas.fachschaften.tu-muenchen.de>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 07:49:45PM +0200, Adrian Bunk wrote:
> Hi,
> 
> I had a crash with 2.4.10-ac10 (the computer was totally frozen - I had to
> push the reset button). I found the following in syslog:
> 
> 
> Oct 10 19:03:05 r063144 kernel: attempt to access beyond end of device
> Oct 10 19:03:05 r063144 kernel: 03:06: rw=0, want=2147449990, limit=1959898

Did you try earlier kernels with success?  
Are your partitions setup correctly?
Which file system(s) was/were on this drive?
Any idea what was happening at the time?

Mike
