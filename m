Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266119AbRF2RMa>; Fri, 29 Jun 2001 13:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266120AbRF2RMV>; Fri, 29 Jun 2001 13:12:21 -0400
Received: from pat.uio.no ([129.240.130.16]:35221 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S266119AbRF2RML>;
	Fri, 29 Jun 2001 13:12:11 -0400
To: "J.R. de Jong" <jdejong@chem.rug.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 NFS io errors
In-Reply-To: <Pine.LNX.4.21.0106281918160.3048-100000@polypc17.chem.rug.nl>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 29 Jun 2001 19:12:05 +0200
In-Reply-To: "J.R. de Jong"'s message of "Thu, 28 Jun 2001 19:31:00 +0200 (CEST)"
Message-ID: <shsvglfyzve.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == J R de Jong <J.R.> writes:

     > Hi all, Recently I upgraded from 2.4.4 to 2.4.5, but after that
     > I got users complaining about io errors on some mounted NFS
     > systems on some files, whenever they tried to stat (ls) or open
     > the file. Even after several reboots (other files failed tho).

     > Going back to 2.4.4 solved the problem. I don't know if this
     > problem has been adressed already.

Sounds like you're using soft mounts?

Cheers,
   Trond
