Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313315AbSC2AZk>; Thu, 28 Mar 2002 19:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313316AbSC2AZa>; Thu, 28 Mar 2002 19:25:30 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:13556
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S313315AbSC2AZV>; Thu, 28 Mar 2002 19:25:21 -0500
Date: Thu, 28 Mar 2002 16:26:58 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.7-dj1
Message-ID: <20020329002658.GF8627@matchmail.com>
Mail-Followup-To: Andre Hedrick <andre@linux-ide.org>,
	Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020328015928.A3607@suse.de> <Pine.LNX.4.10.10203271943420.6661-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2002 at 07:44:55PM -0800, Andre Hedrick wrote:
> 
> Anton A reported an error so I need to go back and see what else got
> broken before this release.  Since there is not diag layer anymore it is
> all a pig in a poke :-/

You could always just patch that layer back in to do the testing...
