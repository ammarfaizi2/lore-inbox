Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310579AbSCVAI7>; Thu, 21 Mar 2002 19:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310538AbSCVAIu>; Thu, 21 Mar 2002 19:08:50 -0500
Received: from holomorphy.com ([66.224.33.161]:34958 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S310549AbSCVAIb>;
	Thu, 21 Mar 2002 19:08:31 -0500
Date: Thu, 21 Mar 2002 16:08:23 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Hari Gadi <HGadi@ecutel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: module (kernel) debugging
Message-ID: <20020322000823.GD785@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hari Gadi <HGadi@ecutel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <AF2378CBE7016247BC0FD5261F1EEB210B6A93@EXCHANGE01.domain.ecutel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2002 at 05:15:48PM -0500, Hari Gadi wrote:
> Hi,
> I am new to kernel level development. What are the best ways to debug
> runtime kernel (module). Are there any third party tools for debugging
> the kernel.


http://www.arium.com
http://oss.sgi.com/projects/kdb
http://oss.sgi.com/projects/kgdb
http://lkcd.sourceforge.net
http://bochs.sourceforge.net

... and other simulators with debugging support.


Cheers,
Bill
