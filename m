Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278199AbRJRXBM>; Thu, 18 Oct 2001 19:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278197AbRJRXAx>; Thu, 18 Oct 2001 19:00:53 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:46329
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S278187AbRJRXAm>; Thu, 18 Oct 2001 19:00:42 -0400
Date: Thu, 18 Oct 2001 16:01:09 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Brian C. Thomas" <bcthomas@nature.Berkeley.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: severe performance degradation on serverworks with high mem
Message-ID: <20011018160109.C2467@mikef-linux.matchmail.com>
Mail-Followup-To: "Brian C. Thomas" <bcthomas@nature.Berkeley.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011018125714.A360@nature.Berkeley.edu> <20011018144504.B134@nature.Berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011018144504.B134@nature.Berkeley.edu>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2001 at 02:45:05PM -0700, Brian C. Thomas wrote:
> Hi
> 
> I don't know if this helps, but I seem to have stumbled onto a
> possible "fix" for this...
> 
> With 64GB high memory enabled in kernel 2.4.12-ac3, and mtrr turned
> on, I was able to see all 8GB RAM on my machine by using the old
> 'append="mem=8000M"' command in my lilo.conf file... AND WITH NO LOSS
> OF PERFORMANCE!
> 
> Does that help anyone with defining where this problem is coming from?
> 

The real question is how to reproduce the > 2hr kernel compiles.

Are there any certain steps that would reliably create the problem, and if
so what are they?
