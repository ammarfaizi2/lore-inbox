Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283859AbRLABIb>; Fri, 30 Nov 2001 20:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283860AbRLABIV>; Fri, 30 Nov 2001 20:08:21 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:7417
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S283866AbRLABHX>; Fri, 30 Nov 2001 20:07:23 -0500
Date: Fri, 30 Nov 2001 17:07:15 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Joe Rice <jrice@bigidea.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Still having problems with eepro100
Message-ID: <20011130170715.K504@mikef-linux.matchmail.com>
Mail-Followup-To: Joe Rice <jrice@bigidea.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011130180827.E2265@bigidea.com> <20011130163721.J504@mikef-linux.matchmail.com> <20011130184916.A13868@bigidea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011130184916.A13868@bigidea.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2001 at 06:49:16PM -0600, Joe Rice wrote:
> i guess that explains why i haven't seen the problem again
> on the bed of machines with 2.4.16.  
> Could please explain how you came to your answer?
> maybe this is to obvious to be addressed on the list, but
> please give me a clue.
> 

IIRC the triggers are:
older kernel ( <= 2.4.9)
nfs w/ 1024 byte packets (default) better usually is 8192
lots of network traffic
