Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284780AbRLPUMa>; Sun, 16 Dec 2001 15:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284785AbRLPUMU>; Sun, 16 Dec 2001 15:12:20 -0500
Received: from stine.vestdata.no ([195.204.68.10]:15036 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S284780AbRLPUMQ>; Sun, 16 Dec 2001 15:12:16 -0500
Date: Sun, 16 Dec 2001 21:12:08 +0100
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: Diego Calleja <grundig@teleline.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reiserfs corruption on 2.4.17-rc1!
Message-ID: <20011216211208.D5226@vestdata.no>
In-Reply-To: <20011216184836.A418@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011216184836.A418@diego>; from grundig@teleline.es on Sun, Dec 16, 2001 at 06:48:36PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2001 at 06:48:36PM +0100, Diego Calleja wrote:
> Dec 16 17:40:40 diego kernel: vs-13070: reiserfs_read_inode2: i/o failure
> occurred trying to find stat data of [4160 68669 0x0 SD]

It appears you have a broken harddrive. You can verify this with the
"badblocks" program


-- 
Ragnar Kjørstad
Big Storage
