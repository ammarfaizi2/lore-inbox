Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278434AbRJSPeT>; Fri, 19 Oct 2001 11:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278432AbRJSPeK>; Fri, 19 Oct 2001 11:34:10 -0400
Received: from danielle.hinet.hr ([195.29.254.157]:31899 "EHLO
	danielle.hinet.hr") by vger.kernel.org with ESMTP
	id <S278434AbRJSPeC>; Fri, 19 Oct 2001 11:34:02 -0400
Date: Fri, 19 Oct 2001 17:34:34 +0200
From: Mario Mikocevic <mozgy@hinet.hr>
To: linux-kernel@vger.kernel.org
Subject: RAID and 2.4.12 ?
Message-ID: <20011019173434.A10220@danielle.hinet.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

are there any known problems with software raid and kernel 2.4.12 ?

I have several production servers (Dell poweredge 1550) with active
kernels from range of 2.4.8/2.4.9/2.4.12. All of them are quite loaded
with web/ftp/game/realmedia servers.

Only combination of RAID and 2.4.12 gives me trouble, complete hang,
no output, no ping. Unfortunately I can't reproduce it by will, sometimes
it hangs just after few mins of uptime, sometimes after few hours.

I _do_ have few servers running 2.4.12 quite realiably (not a single reboot yet)
but without RAID on them (heavily loaded list server and very heavily loaded
realmedia server).

Combination of 2.4.9 and RAID works without any problem so far.


Any help? Pointers? Patches ?

-- 
Mario Mikoèeviæ (Mozgy)
mozgy at hinet dot hr
My favourite FUBAR ...
