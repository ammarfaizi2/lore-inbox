Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279739AbRK0OFA>; Tue, 27 Nov 2001 09:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279788AbRK0OEu>; Tue, 27 Nov 2001 09:04:50 -0500
Received: from vega.ipal.net ([206.97.148.120]:53990 "HELO vega.ipal.net")
	by vger.kernel.org with SMTP id <S279739AbRK0OEm>;
	Tue, 27 Nov 2001 09:04:42 -0500
Date: Tue, 27 Nov 2001 08:04:41 -0600
From: Phil Howard <phil-linux-kernel@ipal.net>
To: Joe Korty <l-k@mindspring.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: procfs bloat, syscall bloat [in reference to cpu affinity]
Message-ID: <20011127080441.A12419@vega.ipal.net>
In-Reply-To: <1006832357.1385.3.camel@icbm> <5.0.2.1.2.20011127022738.009f14b0@pop.mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.0.2.1.2.20011127022738.009f14b0@pop.mindspring.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2001 at 03:04:27AM -0500, Joe Korty wrote:

| I am not against a proc interface per se, I would like a proc interface, 
| especially for the
| reading of affinity values.  But in my view the system call interface 
| should also exist
| and it should be the dominate way of communicating affinity to processes.

IWSTM that the way you would justify this being a system call would also
suggest working with non-linux kernel developers (both open source as well
as commercial) to determine a mutually agreed syntax/semantic for this
call to further ensure the basis of the universality that ensure it will
be one of those "forever" facilities, and maybe even make it into a future
standard.

You opened the camel's mouth; do you want to check the teeth?

-- 
-----------------------------------------------------------------
| Phil Howard - KA9WGN |   Dallas   | http://linuxhomepage.com/ |
| phil-nospam@ipal.net | Texas, USA | http://phil.ipal.org/     |
-----------------------------------------------------------------
