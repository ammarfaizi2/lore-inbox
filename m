Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310979AbSDMXT4>; Sat, 13 Apr 2002 19:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311121AbSDMXTz>; Sat, 13 Apr 2002 19:19:55 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:56823
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S310979AbSDMXTz>; Sat, 13 Apr 2002 19:19:55 -0400
Date: Sat, 13 Apr 2002 16:22:16 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Michal =?unknown-8bit?Q?Maru=B9ka?= <mmc@maruska.dyndns.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: copy-on-write directories (is possible?)
Message-ID: <20020413232216.GS23513@matchmail.com>
Mail-Followup-To: Michal =?unknown-8bit?Q?Maru=B9ka?= <mmc@maruska.dyndns.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <m28z7t6mni.fsf@linux11.maruska.tin.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2002 at 04:01:53PM +0200, Michal Maru?ka wrote:
> 
> is there some FS, which permits a backup snapshot share unchanged files w/
> working directory ?

Yes, with lvm and ext3 or reiserfs you can do this.
