Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292983AbSCBRaU>; Sat, 2 Mar 2002 12:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293083AbSCBRaL>; Sat, 2 Mar 2002 12:30:11 -0500
Received: from pat.uio.no ([129.240.130.16]:27307 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S292983AbSCBR34>;
	Sat, 2 Mar 2002 12:29:56 -0500
To: "dan@radom.org" <dan@radom.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfs task foo can't get a requested slot client errors
In-Reply-To: <20020302063533.GH6260@lunar.radom.org>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 02 Mar 2002 18:29:45 +0100
In-Reply-To: <20020302063533.GH6260@lunar.radom.org>
Message-ID: <shsu1ryc1yu.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == dan radom <dan@radom.org> writes:

     > Please cc me in any replies, as I'm not subscribed to this
     > list.  With recent kernel releases (2.4.17 and 18) I've had nfs
     > client problems (nfs task foo can't get a requested slot).
     > I've read what I can about this error, but don't see anything
     > pertaining to recent kernels.  Anything with a rsize or wsize
     > greater than 3072 dies under what I'm guessing are RPC
     > problems.  Server load isn't an issue here.  What can this be?
     > The nfsd is running 2.4.17, and several other 2.4.17 clients
     > can nfs with default rsize and wsize of 8192.  I'm using a
     > xircom 10/100/56K cardbus ethernet adapter.  Client kernel nfs
     > config includes both CONFIG_NFS_FS=m and CONFIG_NFS_V3=y

RTFM: http://nfs.sourceforge.net

Cheers,
  Trond
