Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289612AbSAWBTD>; Tue, 22 Jan 2002 20:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289615AbSAWBSx>; Tue, 22 Jan 2002 20:18:53 -0500
Received: from ns.suse.de ([213.95.15.193]:17936 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289612AbSAWBSh>;
	Tue, 22 Jan 2002 20:18:37 -0500
Date: Wed, 23 Jan 2002 02:18:35 +0100
From: Dave Jones <davej@suse.de>
To: Hans-Peter Jansen <hpj@urpla.net>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] with 2.4.18-pre4+linux-2.4.18-NFS_ALL
Message-ID: <20020123021835.B25329@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Hans-Peter Jansen <hpj@urpla.net>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020120164118.D587513E3@shrek.lisa.de> <20020120222722.3972B143F@shrek.lisa.de> <15435.20982.84353.824971@charged.uio.no> <20020123005010.14E071472@shrek.lisa.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020123005010.14E071472@shrek.lisa.de>; from hpj@urpla.net on Wed, Jan 23, 2002 at 01:50:09AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2002 at 01:50:09AM +0100, Hans-Peter Jansen wrote:
 > > I forgot the nfs_cred_file() in the line above. That too is fixed now,
 > > and so fsx is running fine again...
 > Would you like to give me a pointer to the famous fsx?

 It's on my website (url below) in the cruft/ dir, but there
 seem to be 'issues' at host right now. I've put a copy at
 ftp://ftp.kernel.org/pub/linux/kernel/people/davej/tools/
 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
