Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262982AbRFGTRY>; Thu, 7 Jun 2001 15:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262945AbRFGTRO>; Thu, 7 Jun 2001 15:17:14 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:56034 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S262915AbRFGTRG>; Thu, 7 Jun 2001 15:17:06 -0400
Message-ID: <3B1FD356.5EB55F1D@idcomm.com>
Date: Thu, 07 Jun 2001 13:17:42 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel-list <linux-kernel@vger.kernel.org>
Subject: 2.4.6 pre1 and 2.4.5 CONFIG_IP_NF_COMPAT_IPCHAINS missing?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know somewhere there is a menuconfig item corresponding to
CONFIG_IP_NF_COMPAT_IPCHAINS, and that selecting various other iptables
options can make this item disappear and no longer be selectable. But I
have fished all over, have set config to give devel and incomplete
items, tried turning on or off anything possibly related to iptables,
and cannot find this item in the make menuconfig. It still exists in
Documentation/Configure.help, so I assume this has not yet been removed
from available kernel compile options. I've been searching for the means
to interactively select this item, with no luck. Can anyone tell me if
ipchains compatibility has been removed from current config options? If
not, how it can be selected, or if it is broken?

D. Stimits, stimits@idcomm.com
