Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265603AbSLCUOX>; Tue, 3 Dec 2002 15:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265612AbSLCUOX>; Tue, 3 Dec 2002 15:14:23 -0500
Received: from ns.aspic.com ([213.193.2.5]:51216 "EHLO off.aspic.com")
	by vger.kernel.org with ESMTP id <S265603AbSLCUOW>;
	Tue, 3 Dec 2002 15:14:22 -0500
Date: Tue, 3 Dec 2002 21:21:41 +0100
From: Philippe =?ISO-8859-1?B?R3JhbW91bGzp?= 
	<philippe.gramoulle@mmania.com>
To: Gary White <gary@netpathway.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-ac1
Message-Id: <20021203212141.60178c38.philippe.gramoulle@mmania.com>
In-Reply-To: <3DED0EAE.7090705@netpathway.com>
References: <200211292324.gATNOQO26672@devserv.devel.redhat.com>
	<3DED0EAE.7090705@netpathway.com>
Organization: Lycos Europe
X-Mailer: Sylpheed version 0.8.6claws52 (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Reiserfs quota patches for 2.4.20 can be found here.

Quote from Oleg Drokin <green@namesys.com>

"
I have a testing version available at
 ftp://namesys.com/pub/reiserfs-for-2.4/testing/quota-2.4.20

 You can try it and report to me if it breaks (but I hope it won't)
"

Bye,

Philippe



On Tue, 03 Dec 2002 14:06:06 -0600
Gary White <gary@netpathway.com> wrote:

  |  Are the below lines in the 2.4.20-rc1 patch a little premature?
  |  I don't see any patch code for quotas in the reiserfs and I can't
  |  get quotas to work for reiserfs. Am I missing something?
  |  
  |  
  |  -  usage (also called disk quotas). Currently, it works only for the
  |  -  ext2 file system. You need additional software in order to use quota
  |  +  usage (also called disk quotas). Currently, it works for the
  |  +  ext2, ext3, and reiserfs file system. You need additional software
  |  
