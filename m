Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261891AbTCQVAW>; Mon, 17 Mar 2003 16:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261899AbTCQVAW>; Mon, 17 Mar 2003 16:00:22 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:6883 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S261891AbTCQVAV> convert rfc822-to-8bit; Mon, 17 Mar 2003 16:00:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hans-Peter Jansen <hpj@urpla.net>
To: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
       linux-kernel@vger.kernel.org
Subject: Re: FileSystem XFS vs RiserFS vs ext3
Date: Mon, 17 Mar 2003 22:11:13 +0100
User-Agent: KMail/1.4.3
References: <E18uq2v-0004P7-00@calista.inka.de>
In-Reply-To: <E18uq2v-0004P7-00@calista.inka.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303172211.13078.hpj@urpla.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 March 2003 09:32, Bernd Eckenfels wrote:

> NFS is a bit tricky. Reiser used to be broken on it, and at least from
> large XFS NFS Servers I know that they tend to be unstable, still.

The last big problems with NFS on big ReiserFS shares where fixed with 
2.4.19 (IIRC). Since then, at least I haven't experienced any logic 
induced failures in this area with my heavily used diskless setups on 
up to 80 GB ReiserFS, shared with NFS. I enjoy this configuration a lot.

Bye,
Pete

