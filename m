Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292167AbSBTS0B>; Wed, 20 Feb 2002 13:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292157AbSBTSZv>; Wed, 20 Feb 2002 13:25:51 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:11516
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S292153AbSBTSZj>; Wed, 20 Feb 2002 13:25:39 -0500
Date: Wed, 20 Feb 2002 10:26:03 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Diego Calleja <diegocg@teleline.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hang in 2.4.18-rc2-ac1
Message-ID: <20020220182603.GA20060@matchmail.com>
Mail-Followup-To: Diego Calleja <diegocg@teleline.es>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020220192127.622006ff.diegocg@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020220192127.622006ff.diegocg@teleline.es>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2002 at 07:21:27PM +0100, Diego Calleja wrote:
> This happened while using X & kde & wine. Kernel 2.4.18-rc2-ac1
> 
> Feb 20 18:10:15 localhost kernel: Unable to handle kernel paging request at virtual address 000a2e64
> Feb 20 18:10:15 localhost kernel:  printing eip:
> Feb 20 18:10:15 localhost kernel: c017a769
> Feb 20 18:10:15 localhost kernel: *pde = 00000000

run it through cut -c (to get log info out) then ksymoops and post again.

Mike
