Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287804AbSAXNdK>; Thu, 24 Jan 2002 08:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287817AbSAXNdB>; Thu, 24 Jan 2002 08:33:01 -0500
Received: from mgw-x1.nokia.com ([131.228.20.21]:57728 "EHLO mgw-x1.nokia.com")
	by vger.kernel.org with ESMTP id <S287804AbSAXNcs>;
	Thu, 24 Jan 2002 08:32:48 -0500
Message-ID: <3C500D09.4080206@nokia.com>
Date: Thu, 24 Jan 2002 15:32:57 +0200
From: Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
Reply-To: affix-devel@lists.sourceforge.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011023
MIME-Version: 1.0
Newsgroups: comp.os.linux.networking
To: Affix support <affix-support@lists.sourceforge.net>,
        affix-devel@lists.sourceforge.net,
        Bluetooth-Drivers-for-Linux 
	<Bluetooth-Drivers-for-Linux@research.nokia.com>,
        NRC-WALLET DL <DL.NRC-WALLET@nokia.com>,
        linux-net <linux-net@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: New Affix Release: Affix-0_9pre10
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Find new affix release Affix-0_9pre10 on
http://affix.sourceforge.net

- additional locks added
- Added Master Slave switch
   btctl connectrole [master|slave]
- added timeout for HCI commands (for buggy devices)
- fixed action on receiving DM packet
- added kpatch-2.4.17
- fixed btsrv to be compiled w/o SDP
- added *debmod* & *debapp* rules to compile Debian packages
- !!! added additional installation notes


br, Dmitry

-- 
  Dmitry Kasatkin
  Nokia Research Center / Helsinki
  Mobile: +358 50 4836365
  E-Mail: dmitry.kasatkin@nokia.com


NB. Now I am Dmitry Kasatkin instead of Dmitri Kassatkine

