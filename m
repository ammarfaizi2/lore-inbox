Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267138AbSLDWjP>; Wed, 4 Dec 2002 17:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267139AbSLDWjP>; Wed, 4 Dec 2002 17:39:15 -0500
Received: from earth.colorado-research.com ([65.171.192.8]:57261 "EHLO
	earth.colorado-research.com") by vger.kernel.org with ESMTP
	id <S267138AbSLDWjO>; Wed, 4 Dec 2002 17:39:14 -0500
Message-ID: <3DEE85D3.6070009@cora.nwra.com>
Date: Wed, 04 Dec 2002 15:46:43 -0700
From: Orion Poplawski <orion@cora.nwra.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NFS - IRIX client issues
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello -

    I was wondering if there were and know NFS issues with IRIX clients? 
  I'm seeing a problem where an IRIX 6.5.17m client
accessing a linux 2.4.18 (redhat 7.2: -18.7.x) server will hang trying
to access a mount.  No traffic appears to make it to the server so it
appears to be locked up on the client end, but I don't know why.

  Thanks!

  - Orion


