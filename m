Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262935AbSJBC4S>; Tue, 1 Oct 2002 22:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262938AbSJBC4S>; Tue, 1 Oct 2002 22:56:18 -0400
Received: from cliff.cse.wustl.edu ([128.252.166.5]:65267 "EHLO
	cliff.cse.wustl.edu") by vger.kernel.org with ESMTP
	id <S262935AbSJBC4S>; Tue, 1 Oct 2002 22:56:18 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15770.25006.908775.563421@samba.doc.wustl.edu>
Date: Tue, 1 Oct 2002 22:02:06 -0500
From: Krishnakumar B <kitty@cse.wustl.edu>
To: linux-kernel@vger.kernel.org
Subject: usb-uhci renamed under Linux-2.5.40
X-Mailer: VM 7.07 under Emacs 21.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When building Linux-2.5.40, I noted that usb-uhci is renamed to (or maybe a
complete reimplementation) uhci-hcd. How can I set up /etc/modules.conf so
that depending on the kernel that I am running either usb-uhci (2.4.x) or
uhci-hcd (2.5.x) is chosen for the usb-controller ? Is there some simple
alias trick that I am missing ? Is it possible for usb-uhci to be built
with linux-2.5.x ? I didn't see any option when doing a build from scratch
(make mrproper menuconfig).

Please CC me on any replies as I am not on this list.

-kitty.

-- 
Krishnakumar B <kitty at cs dot wustl dot edu>
Distributed Object Computing Laboratory, Washington University in St.Louis
